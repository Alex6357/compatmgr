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
LIST=""
SUM=0

while IFS='' read -r LINE; do
    if echo ${LINE} | grep -q ${GREP_NAME}; then
        SUM=$((SUM + 1))
        URL=${LINE%%[[:space:]]*}
        NAME=${URL#*amd64-}
        gentoo_list="${gentoo_list} ${URL}"
        LIST="${LIST} ${SUM} ${NAME%-*}"
    fi
done < ${DIR}/temp/gentoo-list.txt

while true; do
    CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
             --ok-label "$(trans OK)" \
             --hline "$(trans INSTALLING)Gentoo" \
             --menu "$(trans CHOOSE_GENTOO_TYPE)" \
             0 0 ${SUM} \
             ${LIST} \
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

    ${DIR}/scripts/setup/gentoo.sh
    STATUS=${?}
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
