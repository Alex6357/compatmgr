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
    echo $(trans CHOOSE_DEBIAN_VERSION)
    echo "1) 12 (bookworm)"
    echo "2) 11 (bullseye)"
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
            echo "$(trans INSTALLING)Debian 12 (bookworm)"
            echo $(trans CHOOSE_INSTALL_METHORD)
            echo "1) $(trans METHORD_BOOTSTRAP)"
            # echo "2) $(trans METHORD_PREBUILT)"
            echo "3) $(trans RETURN)"
            echo -n $(trans REQUIRE_CHOICE)

            read CHOICE
            case ${CHOICE} in
            1)
                ${DIR}/scripts/fetch/debian/12/bootstrap.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            # 2)
            #     ${DIR}/scripts/fetch/debian/12/fetch.sh
            #     break
            #     ;;
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
            echo "$(trans INSTALLING)Debian 11 (bullseye)"
            echo $(trans CHOOSE_INSTALL_METHORD)
            echo "1) $(trans METHORD_BOOTSTRAP)"
            # echo "2) $(trans METHORD_PREBUILT)"
            echo "3) $(trans RETURN)"
            echo -n $(trans REQUIRE_CHOICE)

            read CHOICE
            case ${CHOICE} in
            1)
                ${DIR}/scripts/fetch/debian/11/bootstrap.sh
                STATUS=${?}
                if [ ${STATUS} -eq 9 ]; then
                    BACK_TO_MENU=1
                fi
                ;;
            # 2)
            #     ${DIR}/scripts/fetch/debian/11/fetch.sh
            #     break
            #     ;;
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