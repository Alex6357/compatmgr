#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

case ${MACHINE_ARCH} in
amd64)
    FILE="archlinux-bootstrap-x86_64.tar.gz"
    URL="https://mirrors.ustc.edu.cn/archlinux/iso/latest/${FILE}"
    EXTRA="--strip-components 1"
    ;;
arm64)
    FILE="ArchLinuxARM-aarch64-latest.tar.gz"
    URL="https://mirrors.ustc.edu.cn/archlinuxarm/os/${FILE}"
    EXTRA=""
    printf "$(trans NOTICE_UNINSTALL_KERNEL)\n"
    ;;
i386)
    echo $(trans ARCH_NOT_SUPPORTED)
    exit 1
    ;;
esac

export DIST_NAME="arch"
export DIST_FULLNAME="Arch Linux"
DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}

echo ""
${DIR}/scripts/check.sh
echo ""

while true; do
    while true; do
        INSTALL_DIR=${DEFAULT_INSTALL_DIR}
        echo -n "$(trans CHANGE_INSTALL_DIR_OR_NOT)[${INSTALL_DIR}]: "
        read ANSWER
        if [ -z ${ANSWER} ]; then
            break
        else
            USER_INSTALL_DIR=${ANSWER}
        fi
        while true; do
            echo -n "$(trans CONFIRM_INSTALL_DIR_OR_NOT)(${USER_INSTALL_DIR})[yes|NO]: "
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
                echo -n "$(trans WARN_DIR_NOT_EMPTY)(${INSTALL_DIR})[yes|NO]: "
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
echo $(trans NOTICE_INSTALL_DIR)
echo ""

if [ ! -d ${DIR}/temp ]; then
    mkdir ${DIR}/temp
fi

fetch ${URL} -o ${DIR}/temp/${FILE}
STATUS=${?}
if [ ${STATUS} -ne 0 ]; then
    export STATUS
    echo $(trans INSTALL_FAILED_FETCH)
    exit 2
fi

tar xvpf ${DIR}/temp/${FILE} -C ${INSTALL_DIR} --numeric-owner ${EXTRA}

echo $(trans INSTALL_COMPLETE)
echo ""
echo $(trans SETTING_UP)
echo ""
${DIR}/scripts/setup/arch/setup.sh
rm -rf ${DIR}/temp

exit 9
