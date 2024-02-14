#!/bin/sh

export DIR=$(pwd)

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

if ! command -v bsddialog > /dev/null 2>&1; then
    echo $(trans BSDDIALOG_NOT_FOUND)    
    exit 1
fi

if [ ! "`whoami`" = "root" ]; then
    echo $(trans NOT_RUN_BY_ROOT)
    exit 1
fi

case $(sysctl -n hw.machine_arch) in
amd64)
    MACHINE_ARCH=amd64
    ;;
aarch64)
    MACHINE_ARCH=arm64
    ;;
i386)
    MACHINE_ARCH=i386
    ;;
*)
    echo $(trans ARCH_NOT_SUPPORTED)
    exit 1
    ;;
esac

export MACHINE_ARCH

while true; do

    CHOICE=$(bsddialog --cancel-label "$(trans EXIT)" \
             --ok-label "$(trans OK)" \
             --menu "$(trans WELCOME)" \
             0 60 3 \
             "$(trans CHOICE_CHECK)" "$(trans CHOICE_CHECK_DESCRIPTION)" \
             "$(trans CHOICE_INSTALL)" "$(trans CHOICE_INSTALL_DESCRIPTION)" \
             "$(trans CHOICE_REMOVE)" "$(trans CHOICE_REMOVE_DESCRIPTION)" \
             3>&2 2>&1 1>&3)

    case ${CHOICE} in
    "$(trans CHOICE_CHECK)")
        echo ""
        ${DIR}/scripts/check.sh
        STATUS=${?}
        case ${STATUS} in
        0)
            bsddialog --msgbox "$(trans CHECK_SUCCESS)" 0 0
            ;;
        1)
            bsddialog --msgbox "$(trans CHECK_FAILED_LINUX_NOT_STARTED)" 0 0
            ;;
        2)
            bsddialog --msgbox "$(trans CHECK_FAILED_DBUS_NOT_INSTALLED)" 0 0
            ;;
        3)
            bsddialog --msgbox "$(trans CHECK_FAILED_DBUS_NOT_STARTED)" 0 0
            ;;
        4)
            bsddialog --msgbox "$(trans CHECK_FAILED_NULLFS_NOT_LOADED)" 0 0
            ;;
        5)
            bsddialog --msgbox "$(trans CHECK_FAILED_CANCELED)" 0 0
        esac
        ;;

    "$(trans CHOICE_INSTALL)")
        while true; do

            CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
                     --ok-label "$(trans OK)" \
                     --no-description \
                     --menu "$(trans INSTALL_SELECT)" \
                     0 0 7 \
                     Debian debian \
                     Ubuntu ubuntu \
                     Kali kali \
                     Fedora fedora \
                     openSUSE opensuse \
                     Gentoo gentoo \
                     "Arch Linux" "arch linux" \
                     3>&2 2>&1 1>&3)

            case ${CHOICE} in
            "Debian")
                ${DIR}/scripts/debian.sh
                STATUS=${?}
                ;;
            "Ubuntu")
                ${DIR}/scripts/ubuntu.sh
                STATUS=${?}
                ;;
            "Kali")
                ${DIR}/scripts/kali.sh
                STATUS=${?}
                ;;
            "Deepin")
                ${DIR}/scripts/deepin.sh
                STATUS=${?}
                ;;
            "Fedora")
                ${DIR}/scripts/fedora.sh
                STATUS=${?}
                ;;
            "openSUSE")
                ${DIR}/scripts/suse.sh
                STATUS=${?}
                ;;
            "Gentoo")
                ${DIR}/scripts/gentoo.sh
                STATUS=${?}
                ;;
            "Arch Linux")
                ${DIR}/scripts/arch.sh
                STATUS=${?}
                ;;
            *)
                break
                ;;
            esac

            case ${STATUS} in
            0)
                break
                ;;
            5)
                ;;
            2)
                bsddialog --msgbox "$(trans CANCEL_INSTALLATION)" 0 0
                ;;
            3)
                bsddialog --msgbox "$(trans CANCEL_SETUP)" 0 0
                ;;
            esac
        done
        ;;
    "$(trans CHOICE_REMOVE)")
        ${DIR}/scripts/remove.sh
        STATUS=${?}
        case ${STATUS} in
        0)
            ;;
        2)
            bsddialog --msgbox "$(trans ABORT)" 0 0
            ;;
        esac
        ;;
    *)
        echo $(trans GOODBYE)
        exit 0
        ;;
    esac
done