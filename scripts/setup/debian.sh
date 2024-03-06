#!/bin/sh

VERSION=${VERSION:-12}
export DIST_NAME="debian"
export DIST_FULLNAME="Debian ${VERSION}"
export DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}

case ${VERSION} in
11)
    CODENAME="bullseye"
    ;;
12)
    CODENAME="bookworm"
    EXTRA="--exclude=usr-is-merged --include=usrmerge"
    ;;
esac

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

debootstrap ${EXTRA} --arch=${MACHINE_ARCH} ${CODENAME} ${INSTALL_DIR} https://mirrors.ustc.edu.cn/debian
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
    case ${VERSION} in
    12)
        bsddialog --msgbox "$(trans DEBIAN_12_SOURCE_NOT_ADDED)" 0 0
        ;;
    11)
        bsddialog --msgbox "$(trans DEBIAN_11_SOURCE_NOT_ADDED)" 0 0
    ;;
0)
    echo $(trans ADD_SOURCE)
    case ${VERSION} in
    12)
        cat >${INSTALL_DIR}/etc/apt/sources.list.d/debian.sources<< EOF
Types: deb
URIs: https://mirrors.ustc.edu.cn/debian
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: https://mirrors.ustc.edu.cn/debian-security
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb-src
URIs: https://mirrors.ustc.edu.cn/debian
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb-src
URIs: https://mirrors.ustc.edu.cn/debian-security
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
        rm ${INSTALL_DIR}/etc/apt/sources.list
        ;;
    11)
        cat >${INSTALL_DIR}/etc/apt/sources.list<< EOF
deb https://mirrors.ustc.edu.cn/debian bullseye main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian bullseye main contrib non-free

deb https://mirrors.ustc.edu.cn/debian-security/ bullseye-security main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian-security/ bullseye-security main contrib non-free

deb https://mirrors.ustc.edu.cn/debian bullseye-updates main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian bullseye-updates main contrib non-free

deb https://mirrors.ustc.edu.cn/debian bullseye-backports main contrib non-free
deb-src https://mirrors.ustc.edu.cn/debian bullseye-backports main contrib non-free
EOF
        ;;
    esac
    ;;
*)
    exit 2
    ;;
esac

rm -rf ${DIR}/temp

bsddialog --msgbox "$(trans SETUP_COMPLETE)" 0 0

exit 0
