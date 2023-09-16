#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

if [ ! -d ${DIR}/temp ]; then
    mkdir ${DIR}/temp
fi

case ${MACHINE_ARCH} in
amd64)
    export ARCH="amd64"
    GREP_NAME="amd64"
    ;;
arm64)
    export ARCH="arm64"
    GREP_NAME="arm64"
    ;;
i386)
    export ARCH="x86"
    GREP_NAME="\"i*86\""
esac

fetch https://mirrors.ustc.edu.cn/gentoo/releases/${ARCH}/autobuilds/latest-stage3.txt -o ${DIR}/temp/gentoo-list.txt

gentoo_list=""
SUM=0

while IFS='' read -r LINE; do
    if echo ${LINE} | grep -q ${GREP_NAME}; then
        gentoo_list="${gentoo_list} ${LINE%%[[:space:]]*}"
        SUM=$((SUM + 1))
    fi
done < ${DIR}/temp/gentoo-list.txt

while true; do
    if [ ${BACK_TO_MENU} -eq 1 ]; then
        break
    fi
    echo ""
    echo $(trans CHOOSE_GENTOO_TYPE)
    COUNT=0
    for TYPE in ${gentoo_list}; do
        COUNT=$((COUNT+1))
        NAME=${TYPE#*amd64-}
        echo "${COUNT}) ${NAME%-*}"
    done
    echo "r) $(trans RETURN)"
    echo -n $(trans REQUIRE_CHOICE)

    read CHOICE
    case ${CHOICE} in
    [0-9]*)
        if [ ${CHOICE} -gt 0 ] && [ ${CHOICE} -lt $((SUM+1)) ]; then
            COUNT=0
            for TYPE in ${gentoo_list}; do
                COUNT=$((COUNT+1))
                if [ ${COUNT} -eq ${CHOICE} ]; then
                    break
                fi
            done
            export TYPE
            NAME=${TYPE#*amd64-}
            NAME=${NAME%-*}
            export NAME
            ${DIR}/scripts/fetch/gentoo.sh
            STATUS=${?}
            if [ ${STATUS} -eq 9 ]; then
                BACK_TO_MENU=1
            fi
        fi
        ;;
    r)
        break
        ;;
    *)
        ;;
    esac
done

if [ ${BACK_TO_MENU} -eq 1 ]; then
    exit 9
fi