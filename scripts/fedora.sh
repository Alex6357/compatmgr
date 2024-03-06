#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

if [ "${MACHINE_ARCH}" = "i386" ]; then
    bsddialog --msgbox "$(trans FEDORA_ARCH_NOT_SUPPORTED)" 0 0
    exit 1
fi

while true; do
    CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
             --ok-label "$(trans OK)" \
             --hline "$(trans INSTALLING)Fedora" \
             --menu "$(trans CHOOSE_FEDORA_TYPE)" \
             0 0 2 \
             "Base" "" \
             "Minimal Base" "$(trans MINIMAL_NOT_RECOMMENDED)" \
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
    "Base")
        export TYPE="Base"
        ${DIR}/scripts/setup/fedora.sh
        STATUS=${?}
        ;;
    "Minimal Base")
        export TYPE="Minimal-Base"
        ${DIR}/scripts/setup/fedora.sh
        STATUS=${?}
        ;;
    *)
        exit 2
        ;;
    esac
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
done
