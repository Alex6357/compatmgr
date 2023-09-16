#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

while true; do
    if [ ${BACK_TO_MENU} -eq 1 ]; then
        break
    fi
    echo ""
    echo $(trans CHOOSE_SUSE_VERSION)
    echo "1) Leap 15.5"
    echo "2) Tumbleweed"
    echo "3) $(trans RETURN)"
    echo -n $(trans REQUIRE_CHOICE)

    read CHOICE
    case ${CHOICE} in
    1)
        while true; do
            if [ ${BACK_TO_MENU} -eq 1 ]; then
                break
            fi
            echo ""
            echo "$(trans INSTALLING)openSUSE Leap 15.5"
            echo $(trans CHOOSE_INSTALL_TYPE)
            echo "1) $(trans TYPE_ZYPPER)"
            echo "2) $(trans TYPE_DNF)"
            echo "3) $(trans RETURN)"
            echo -n $(trans REQUIRE_CHOICE)

            read CHOICE
            case ${CHOICE} in
            1)
                ${DIR}/scripts/fetch/suse/leap/15.5/zypper.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            2)
                ${DIR}/scripts/fetch/suse/leap/15.5/dnf.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            3)
                break
                ;;
            *)
                ;;
            esac
        done
        ;;
    2)
        while true; do
            if [ ${BACK_TO_MENU} -eq 1 ]; then
                break
            fi
            echo ""
            echo "$(trans INSTALLING)openSUSE Tunbleweed"
            echo $(trans CHOOSE_INSTALL_TYPE)
            echo "1) $(trans TYPE_ZYPPER)"
            echo "2) $(trans TYPE_DNF)"
            echo "3) $(trans RETURN)"
            echo -n $(trans REQUIRE_CHOICE)

            read CHOICE
            case ${CHOICE} in
            1)
                ${DIR}/scripts/fetch/suse/tumbleweed/zypper.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            2)
                ${DIR}/scripts/fetch/suse/tumbleweed/dnf.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            3)
                break
                ;;
            *)
                ;;
            esac
        done
        ;;
    3)
        break
        ;;
    *)
        ;;
    esac
done

if [ ${BACK_TO_MENU} -eq 1 ]; then
    exit 9
fi