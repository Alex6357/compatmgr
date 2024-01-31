#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

while true; do
    CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
             --ok-label "$(trans OK)" \
             --hline "$(trans INSTALLING)Arch Linux" \
             --menu "$(trans CHOOSE_INSTALL_METHORD)" \
             0 0 2 \
             "prebuilt" "$(trans METHORD_USTC_PREBUILT)" \
             "pacman" "$(trans METHORD_PACMAN)" \
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
    "prebuilt")
        export METHORD="prebuilt"
        ${DIR}/scripts/setup/arch.sh
        STATUS=${?}
        ;;
    "pacman")
        export METHORD="pacman"
        ${DIR}/scripts/setup/arch.sh
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
