#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/fetch/ubuntu/2004/fetch_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/fetch/ubuntu/2004/fetch_sh/en_US.sh
fi

if [ ${MACHINE_ARCH} = "i386" ]; then
    echo $(tr ARCH_NOT_SUPPORTED_FETCH)
    exit 1
fi

export DIST_NAME="ubuntu"
export DIST_FULLNAME="Ubuntu ${VERSION}"
DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}
SUB_VERSION=".5"
VERSION="20.04"
URL="https://mirrors.ustc.edu.cn/ubuntu-cdimage/ubuntu-base/releases/focal/release"
FILE="ubuntu-base-${VERSION}${SUB_VERSION}-base-${MACHINE_ARCH}.tar.gz"

echo ""
${DIR}/scripts/check.sh
echo ""

while true; do
    while true; do
        INSTALL_DIR=${DEFAULT_INSTALL_DIR}
        echo -n "$(tr CHANGE_INSTALL_DIR_OR_NOT)[${INSTALL_DIR}]: "
        read ANSWER
        if [ -z ${ANSWER} ]; then
            break
        else
            USER_INSTALL_DIR=${ANSWER}
        fi
        while true; do
            echo -n "$(tr CONFIRM_INSTALL_DIR_OR_NOT)(${USER_INSTALL_DIR})[yes|NO]: "
            read ANSWER
            case ${ANSWER} in
            [Yy][Ee][Ss])
                INSTALL_DIR=${USER_INSTALL_DIR}
                break
                ;;
            *)
                break
                ;;
            esac
        done
        if [ ${INSTALL_DIR} = ${USER_INSTALL_DIR} ]; then
            break
        fi
    done
    if [ -d ${INSTALL_DIR} ]; then
        if [ "$(ls -A ${INSTALL_DIR})" ]; then
            FORCE_INSTALL=0
            while true; do
                echo -n "$(tr WARN_DIR_NOT_EMPTY)(${INSTALL_DIR})[yes|NO]: "
                read ANSWER
                case ${ANSWER} in
                [Yy][Ee][Ss])
                    FORCE_INSTALL=1
                    break
                    ;;
                *)
                    break
                    ;;
                esac
            done
            if [ ${FORCE_INSTALL} -eq 1 ]; then
                break
            fi
        else
            break
        fi
    else
        mkdir -p ${INSTALL_DIR}
        break
    fi          
done

echo ""
echo $(tr NOTICE_INSTALL_DIR)
echo ""

if [ ! -d ${DIR}/temp ]; then
    mkdir ${DIR}/temp
fi

fetch ${URL}/${FILE} -o ${DIR}/temp/${FILE}
STATUS=${?}
if [ ${STATUS} -ne 0 ]; then
    export STATUS
    echo $(tr INSTALL_FAILED_FETCH)
    exit 2
fi

tar xvpf ${DIR}/temp/${FILE} -C ${INSTALL_DIR} --numeric-owner

STATUS=${?}
if [ ${STATUS} -ne 0 ]; then
    export STATUS
    echo $(tr INSTALL_FAILED_TAR)
    exit 3
else
    echo $(tr INSTALL_COMPLETE)
    echo ""
    echo $(tr SETTING_UP)
    echo ""
    ${DIR}/scripts/setup/ubuntu/2004/setup.sh
    rm -rf ${DIR}/temp
fi

exit 9