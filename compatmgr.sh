#!/bin/sh

export DIR=$(pwd)

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/compatmgr_sh/zh_CN.sh
else
    . ${DIR}/i18n/compatmgr_sh/en_US.sh
fi

if [ ! "`whoami`" = "root" ]; then
    echo $(tr NOT_RUN_BY_ROOT)
    exit 1
fi

while true; do
    export BACK_TO_MENU=0
    echo ""
    echo $(tr WELCOME)
    echo $(tr PLEASE_SELECT)
    echo "1) $(tr CHOICE_CHECK)"
    echo "2) $(tr CHOICE_INSTALL)"
    # echo "3) $(tr CHOICE_REMOVE)"
    echo "4) $(tr CHOICE_EXIT)"
    echo -n $(tr REQUIRE_CHOICE)

    read CHOICE
    case ${CHOICE} in
    1)
        echo ""
        ${DIR}/scripts/check.sh
        STATUS=${?}
        case ${STATUS} in
        0)
            echo ""
            echo $(tr CHECK_SUCCESS)
            ;;
        1)
            echo ""
            echo $(tr CHECK_FAILED_LINUX_NOT_STARTED)
            ;;
        2)
            echo ""
            echo $(tr CHECK_FAILED_DBUS_NOT_INSTALLED)
            ;;
        3)
            echo ""
            echo $(tr CHECK_FAILED_DBUS_NOT_STARTED)
            ;;
        4)
            echo ""
            echo $(tr CHEKC_FAILED_NULLFS_NOT_LOADED)
            ;;
        esac
        ;;
    2)
        while true; do
            if [ ${BACK_TO_MENU} -eq 1 ]; then
                break
            fi
            echo ""
            echo $(tr INSTALL_SELECT)
            echo "1) Debian"
            echo "2) Ubuntu"
            echo "3) Kali"
            echo "4) Deepin"
            echo "5) Fedora"
            echo "6) $(tr CHOICE_RETURN)"
            echo -n $(tr REQUIRE_CHOICE)

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
                break
                ;;
            *)
                ;;
            esac
        done
        ;;
    # 3)
    #     while true; do
    #         if [ ${BACK_TO_MENU} -eq 1 ]; then
    #             break
    #         fi
    #         echo ""
    #         echo $(tr REMOVE_SELECT)
    #         echo "1) Debian"
    #         echo "2) $(tr CHOICE_RETURN)"
    #         echo -n $(tr REQUIRE_CHOICE)
    #         read CHOICE

    #         case ${CHOICE} in
    #         1)
    #             ${DIR}/scripts/remove/debian.sh
    #             ;;
    #         2)
    #             break
    #             ;;
    #         *)
    #             ;;
    #         esac
    #     done
    #     ;;
    4)
        echo $(tr GOODBYE)
        exit 0
        ;;
    *)
        ;;
    esac
done