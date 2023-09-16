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
    echo $(trans CHOOSE_FEDORA_TYPE)
    echo "1) Base"
    echo "2) Minimal Base $(trans MINIMAL_NOT_RECOMMENDED)"
    echo "3) $(trans RETURN)"
    echo -n $(trans REQUIRE_CHOICE)

    read CHOICE
    case ${CHOICE} in
    1)
        ${DIR}/scripts/fetch/fedora/base.sh
        STATUS=${?}
        if [ ${STATUS} -eq 9 ]; then
            BACK_TO_MENU=1
        fi
        ;;
    2)
        ${DIR}/scripts/fetch/fedora/minimal.sh
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

if [ ${BACK_TO_MENU} -eq 1 ]; then
    exit 9
fi