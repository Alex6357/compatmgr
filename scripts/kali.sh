#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/kali_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/kali_sh/en_US.sh
fi

while true; do
    if [ ${BACK_TO_MENU} -eq 1 ]; then
        break
    fi
    echo ""
    echo "$(tr INSTALLING)Kali"
    echo $(tr CHOOSE_INSTALL_METHORD)
    echo "1) $(tr METHORD_BOOTSTRAP)"
    # echo $(tr METHORD_FETCH)
    echo "3) $(tr RETURN)"
    echo -n $(tr REQUIRE_CHOICE)

    read CHOICE
    case ${CHOICE} in
    1)
        ${DIR}/scripts/fetch/kali/bootstrap.sh
        STATUS=${?}
        if [ ${STATUS} -eq 9 ]; then
            BACK_TO_MENU=1
        fi
        ;;
    # 2)
    #     ${DIR}/scripts/fetch/kali/fetch.sh
    #     STATUS=${?}
    #     if [ ${STATUS} -eq 9 ]; then
    #         BACK_TO_MENU=1
    #     fi
    #     ;;
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