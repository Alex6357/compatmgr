#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

while true; do
    CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
             --ok-label "$(trans OK)" \
             --hline "$(trans INSTALLING)Kali" \
             --menu "$(trans CHOOSE_INSTALL_METHORD)" \
             0 0 1 \
             "debootstrap" "$(trans METHORD_BOOTSTRAP)" \
             3>&2 2>&1 1>&3)
    STATUS=${?}
    case ${STATUS} in
    1)
        exit 5
        ;;
    0)
        ;;
    *)
        exit 2
        ;;
    esac

    case ${CHOICE} in
    "debootstrap")
        export METHORD="debootstrap"
        ${DIR}/scripts/setup/kali.sh
        STATUS=${?}
        case ${STATUS} in
        0)
            exit 0
            ;;
        1)
            exit 2
            ;;
        2)
            exit 3
            ;;
        esac
        ;;
    # 2)
    #     ${DIR}/scripts/fetch/kali/fetch.sh
    #     STATUS=${?}
    #     if [ ${STATUS} -eq 9 ]; then
    #         BACK_TO_MENU=1
    #     fi
    #     ;;
    *)
        exit 2
        ;;
    esac
done
