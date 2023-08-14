#!/bin/sh

export DIST_NAME="gentoo"
export DIST_FULLNAME="Gentoo ${NAME}"
DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}
FILE=${TYPE#*/}
URL=https://mirrors.ustc.edu.cn/gentoo/releases/amd64/autobuilds/${TYPE}

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/fetch/gentoo_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/fetch/gentoo_sh/en_US.sh
fi

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

# fetch ${URL} -o ${DIR}/temp/${FILE}
# STATUS=${?}
# if [ ${STATUS} -ne 0 ]; then
#     export STATUS
#     echo $(tr INSTALL_FAILED_FETCH)
#     exit 2
# fi

# tar xvpf ${DIR}/temp/${FILE} -C ${INSTALL_DIR} --numeric-owner
# STATUS=${?}
# if [ ${STATUS} -ne 0 ]; then
#     export STATUS
#     echo $(tr INSTALL_FAILED_TAR)
#     exit 3
# else
#     echo $(tr INSTALL_COMPLETE)
#     echo ""
#     echo $(tr SETTING_UP)
#     echo ""
#     ${DIR}/scripts/setup/gentoo/setup.sh
#     rm -rf ${DIR}/temp
# fi

${DIR}/scripts/setup/gentoo/setup.sh
exit 9
