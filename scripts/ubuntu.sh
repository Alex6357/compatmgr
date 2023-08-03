#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/ubuntu_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/ubuntu_sh/en_US.sh
fi

while true; do
    if [ ${BACK_TO_MENU} -eq 1 ]; then
        break
    fi
    echo ""
    echo $(tr CHOOSE_UBUNTU_VERSION)
    echo "1) 22.04 (jammy)"
    echo "2) 20.04 (focal)"
    echo "3) $(tr RETURN)"
    echo -n $(tr REQUIRE_CHOICE)

    read CHOICE
    case ${CHOICE} in
    1)
        while true; do
            if [ ${BACK_TO_MENU} -eq 1 ]; then
                break
            fi
            echo ""
            echo "$(tr INSTALLING)Ubuntu 22.04 (jammy)"
            echo $(tr CHOOSE_INSTALL_METHORD)
            echo "1) $(tr METHORD_BOOTSTRAP)"
            echo "2) $(tr METHORD_PREBUILT)"
            echo "3) $(tr RETURN)"
            echo -n $(tr REQUIRE_CHOICE)

            read CHOICE
            case ${CHOICE} in
            1)
                ${DIR}/scripts/fetch/ubuntu/2204/bootstrap.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            2)
                ${DIR}/scripts/fetch/ubuntu/2204/fetch.sh
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
            echo "$(tr INSTALLING)Ubuntu 20.04 (focal)"
            echo $(tr CHOOSE_INSTALL_METHORD)
            echo "1) $(tr METHORD_BOOTSTRAP)"
            echo "2) $(tr METHORD_PREBUILT)"
            echo "3) $(tr RETURN)"
            echo -n $(tr REQUIRE_CHOICE)

            read CHOICE
            case ${CHOICE} in
            1)
                ${DIR}/scripts/fetch/ubuntu/2004/bootstrap.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            2)
                ${DIR}/scripts/fetch/ubuntu/2004/fetch.sh
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