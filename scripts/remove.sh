#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

while true; do
    DIRECTORY=$(bsddialog  --cancel-label "$(trans RETURN)" \
                --ok-label "$(trans OK)" \
                --inputbox "$(trans ENTER_DIR)" \
                0 0 \
                3>&2 2>&1 1>&3)
    STATUS=${?}
    case ${STATUS} in
    0)
        ;;
    1)
        exit 0
        ;;
    *)
        exit 2
        ;;
    esac

    DIRECTORY=$(echo ${DIRECTORY} | sed 's|[/]\{1,\}|/|g')
    DIRECTORY=${DIRECTORY#/}
    DIRECTORY=${DIRECTORY%/}
    DIRECTORY="/${DIRECTORY}"

    case ${DIRECTORY} in
    ""|"/")
        bsddialog --msgbox "$(trans WARN_ROOT_DIR)" 0 0
        continue
        ;;
    *)
        ;;
    esac

    if ! [ -f ${DIRECTORY}/etc/os-release ]; then
        bsddialog --yesno --default-no "$(trans WARN_NOT_LINUX)" 0 0
        ANSWER=${?}
        case ${ANSWER} in
        0)
            break
            ;;
        *)
            continue
            ;;
        esac
    fi
    break
done

bsddialog --yesno --default-no "$(trans WARN_REMOVE)" 0 0
ANSWER=${?}
case ${ANSWER} in
0)
    ;;
*)
    exit 2
    ;;
esac

umount -f $(mount | grep -o -e "${DIRECTORY}/[^ ]*")
rm -rf ${DIRECTORY}

DIRECTORY=$(echo ${DIRECTORY} | sed 's/\//\\\//g')
sed -i '' -e "/${DIRECTORY}\//d" /etc/fstab
bsddialog --msgbox "$(trans DONE)" 0 0
exit 0
