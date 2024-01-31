#!/bin/sh

SUB_VERSION="1.5"
VERSION="39"
TYPE=${TYPE:-"Base"}
export DIST_NAME="fedora"
export DIST_FULLNAME="Fedora ${VERSION} ${TYPE}"
export DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}
FILE=Fedora-Container-${TYPE}-${VERSION}-${SUB_VERSION}.${ARCH}.tar.xz
URL=https://mirrors.ustc.edu.cn/fedora/releases/${VERSION}/Container/${ARCH}/images/${FILE}

if [ "${TYPE}" = "Minimal-Base" ]; then
    IS_MINIMAL=1
fi

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

. ${DIR}/scripts/setup/utils.sh

${DIR}/scripts/check.sh
STATUS=${?}
if [ ${STATUS} -ne 0 ]; then
    exit 1
fi

INSTALL_DIR=$(get_install_dir)
if [ "${INSTALL_DIR}" = "" ]; then
    exit 1
fi

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
    bsddialog --msgbox "$(trans INSTALL_FAILED_FETCH)" 0 0
    exit 3
fi

mkdir -p ${INSTALL_DIR}

tar xvpf ${DIR}/temp/${FILE} -C ${INSTALL_DIR} --numeric-owner
STATUS=${?}
if [ ${STATUS} -ne 0 ]; then
    export STATUS
    bsddialog --msgbox "$(trans INSTALL_FAILED_TAR)" 0 0
    exit 4
fi

echo $(trans INSTALL_COMPLETE)
echo $(trans SETTING_UP)

${DIR}/scripts/setup/basic.sh

bsddialog --yesno "$(trans ADD_SOURCE_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
1)
    bsddialog --msgbox "$(trans SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)" 0 0
    mkdir -p ${INSTALL_DIR}/var/db/repos/gentoo
    ;;
0)
    echo $(trans ADD_SOURCE)
    if [ ${IS_MINIMAL} -eq 1 ]; then
        sed -e 's|^metalink=|#metalink=|g' \
        -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
        -i '.bak' \
        ${INSTALL_DIR}/etc/yum.repos.d/fedora.repo \
        ${INSTALL_DIR}/etc/yum.repos.d/fedora-updates.repo
    else
        sed -e 's|^metalink=|#metalink=|g' \
        -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
        -i '.bak' \
        ${INSTALL_DIR}/etc/yum.repos.d/fedora.repo \
        ${INSTALL_DIR}/etc/yum.repos.d/fedora-modular.repo \
        ${INSTALL_DIR}/etc/yum.repos.d/fedora-updates.repo \
        ${INSTALL_DIR}/etc/yum.repos.d/fedora-updates-modular.repo
    fi
    ;;
*)
    exit 2
    ;;
esac

rm -rf ${DIR}/temp

bsddialog --msgbox "$(trans SETUP_COMPLETE)" 0 0

exit 0
