#!/bin/sh

export DIR=$(pwd)

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/compatmgr_sh/zh_CN.sh
else
    . ${DIR}/i18n/compatmgr_sh/en_US.sh
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
    export BACK_TO_MENU=0
    echo ""
    echo $(trans WELCOME)
    echo $(trans PLEASE_SELECT)
    echo "1) $(trans CHOICE_CHECK)"
    echo "2) $(trans CHOICE_INSTALL)"
    echo "3) $(trans CHOICE_REMOVE)"
    echo "4) $(trans CHOICE_EXIT)"
    echo -n $(trans REQUIRE_CHOICE)

    read CHOICE
    case ${CHOICE} in
    1)
        echo ""
        ${DIR}/scripts/check.sh
        STATUS=${?}
        case ${STATUS} in
        0)
            echo ""
            echo $(trans CHECK_SUCCESS)
            ;;
        1)
            echo ""
            echo $(trans CHECK_FAILED_LINUX_NOT_STARTED)
            ;;
        2)
            echo ""
            echo $(trans CHECK_FAILED_DBUS_NOT_INSTALLED)
            ;;
        3)
            echo ""
            echo $(trans CHECK_FAILED_DBUS_NOT_STARTED)
            ;;
        4)
            echo ""
            echo $(trans CHEKC_FAILED_NULLFS_NOT_LOADED)
            ;;
        esac
        ;;
    2)
        while true; do
            if [ ${BACK_TO_MENU} -eq 1 ]; then
                break
            fi
            echo ""
            echo $(trans INSTALL_SELECT)
            echo "1) Debian"
            echo "2) Ubuntu"
            echo "3) Kali"
            echo "4) Deepin"
            echo "5) Fedora"
            echo "6) openSUSE"
            echo "7) Gentoo"
            echo "8) Arch Linux"
            echo "9) $(trans CHOICE_RETURN)"
            echo -n $(trans REQUIRE_CHOICE)

            read CHOICE
            case ${CHOICE} in
            1)
                ${DIR}/scripts/debian.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            2)
                ${DIR}/scripts/ubuntu.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            3)
                ${DIR}/scripts/kali.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            4)
                ${DIR}/scripts/deepin.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            5)
                ${DIR}/scripts/fedora.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            6)
                ${DIR}/scripts/suse.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            7)
                ${DIR}/scripts/gentoo.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            8)
                ${DIR}/scripts/fetch/arch.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            9)
                break
                ;;
            *)
                ;;
            esac
        done
        ;;
    3)
        ${DIR}/scripts/remove.sh
        ;;
    4)
        echo $(trans GOODBYE)
        exit 0
        ;;
    *)
        ;;
    esac
done