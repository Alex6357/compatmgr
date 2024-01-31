#!/bin/sh

export DIST_NAME="kali"
export DIST_FULLNAME="Kali"
export DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}

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

check_debootstrap
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

debootstrap --exclude=usr-is-merged --include=usrmerge --arch=${MACHINE_ARCH} kali-rolling ${INSTALL_DIR} https://mirrors.ustc.edu.cn/kali
STATUS=${?}
if [ ${STATUS} -ne 0 ]; then
    export STATUS
    bsddialog --msgbox "$(trans INSTALL_FAILED)" 0 0
    exit 3
fi

echo $(trans REMOVE_DEBOOTSTRAP_FILES)
rm -rf ${INSTALL_DIR}/debootstrap
echo $(trans INSTALL_COMPLETE)
echo $(trans SETTING_UP)

${DIR}/scripts/setup/basic.sh

bsddialog --yesno "$(trans ADD_SOURCE_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
1)
    bsddialog --msgbox "$(trans KALI_SOURCE_NOT_ADDED)" 0 0
    ;;
0)
    echo $(trans ADD_SOURCE)
    cat >${INSTALL_DIR}/etc/apt/sources.list<< EOF
deb https://mirrors.ustc.edu.cn/kali kali-rolling main contrib non-free non-free-firmware
deb-src https://mirrors.ustc.edu.cn/kali kali-rolling main contrib non-free non-free-firmware
EOF
    ;;
*)
    exit 2
    ;;
esac

rm -rf ${DIR}/temp

bsddialog --msgbox "$(trans SETUP_COMPLETE)" 0 0

exit 0
