#!/bin/sh

export DIST_NAME="debian"
export DIST_FULLNAME="Debian 11"
DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

echo ""
${DIR}/scripts/check.sh
echo ""

if ! which -s debootstrap; then
    while true; do
        echo -n "$(trans INSTALL_DEBOOTSTRAP_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans INSTALL_FAILED_DEBOOTSTRAP_NOT_INSTALLED)
            exit 1;
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans INSTALL_DEBOOTSTRAP)
            pkg install -y debootstrap
            break
            ;;
        *)
            ;;
        esac
    done
fi

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

debootstrap --arch=${MACHINE_ARCH} bullseye ${INSTALL_DIR} https://mirrors.ustc.edu.cn/debian

STATUS=${?}
if [ ${STATUS} -ne 0 ]; then
    export STATUS
    echo $(trans INSTALL_DEBOOTSTRAP_FAILED)
    exit ${STATUS}
else
    echo $(trans INSTALL_COMPLETE)
    echo ""
    echo $(trans SETTING_UP)
    echo ""
    ${DIR}/scripts/setup/debian/11/setup.sh
fi

exit 9