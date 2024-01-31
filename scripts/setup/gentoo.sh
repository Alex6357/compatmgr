#!/bin/sh

export DIST_NAME="gentoo"
export DIST_FULLNAME="Gentoo ${NAME}"
export DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}
export FILE=${TYPE#*/}
export URL=https://mirrors.ustc.edu.cn/gentoo/releases/${ARCH}/autobuilds/${TYPE}

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

echo $(trans ADD_FEATURES)
echo "FEATURES=\"-ipc-sandbox -mount-sandbox -network-sandbox -pid-sandbox -xattr -sandbox -usersandbox\"" >> ${INSTALL_DIR}/etc/portage/make.conf

echo $(trans COPY_REPO_CONFIG)
cp ${INSTALL_DIR}/usr/share/portage/config/repos.conf ${INSTALL_DIR}/etc/portage/repos.conf


bsddialog --yesno "$(trans ADD_SOURCE_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
1)
    bsddialog --msgbox "$(trans SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)" 0 0
    mkdir -p ${INSTALL_DIR}/var/db/repos/gentoo
    ;;
0)
    echo $(trans ADD_SOURCE)
    echo "GENTOO_MIRRORS=\"https://mirrors.ustc.edu.cn/gentoo/\"" >> ${INSTALL_DIR}/etc/portage/make.conf
    sed -i '' \
    -e 's/rsync.gentoo.org/rsync.mirrors.ustc.edu.cn/g' \
    -e 's|/var/db/repos/gentoo|/var/db/repos/ustc|g' \
    ${INSTALL_DIR}/etc/portage/repos.conf
    mkdir -p ${INSTALL_DIR}/var/db/repos/ustc
    ;;
*)
    exit 2
    ;;
esac

rm -rf ${DIR}/temp

bsddialog --msgbox "$(trans SETUP_COMPLETE)" 0 0

exit 0
