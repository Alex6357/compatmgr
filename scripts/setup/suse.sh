#!/bin/sh

case ${MACHINE_ARCH} in
"amd64")
    ARCH="x86_64"
    ;;
"arm64")
    ARCH="aarch64"
    ;;
"i386")
    bsddialog --msgbox "$(trans OPENSUSE_ARCH_NOT_SUPPORTED)" 0 0
    exit 1
    ;;
esac

export DIST_NAME="suse"
TYPE=${TYPE:-"Leap"}
VERSION=${VERSION:-"15.5"}
PKG=${PKG:-zypper}
case ${TYPE} in
"Leap")
    export DIST_FULLNAME="openSUSE Leap ${VERSION}"
    case ${PKG} in
    "zypper")
        FILE="opensuse-leap-image.${ARCH}-lxc.tar.xz"
        ;;
    "dnf")
        FILE="opensuse-leap-dnf-image.${ARCH}-lxc-dnf.tar.xz"
        ;;
    esac
    URL="https://download.opensuse.org/distribution/leap/${VERSION}/appliances/${FILE}"
    # URL="https://mirrors.ustc.edu.cn/opensuse/distribution/leap/${VERSION}/appliances/${FILE}"
    ;;
"Tumbleweed")
    export DIST_FULLNAME="openSUSE Tumbleweed"
    case ${PKG} in
    "zypper")
        FILE="opensuse-tumbleweed-image.${ARCH}-lxc.tar.xz"
        ;;
    "dnf")
        FILE="opensuse-tumbleweed-dnf-image.${ARCH}-lxc-dnf.tar.xz"
        ;;
    esac
    URL="https://download.opensuse.org/tumbleweed/appliances/${FILE}"
    # URL="https://mirrors.ustc.edu.cn/opensuse/tumbleweed/appliances/${FILE}"
    ;;
esac
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
# STATUS=${?}
# if [ ${STATUS} -ne 0 ]; then
#     export STATUS
#     bsddialog --msgbox "$(trans INSTALL_FAILED_TAR)" 0 0
#     exit 3
# fi

echo $(trans INSTALL_COMPLETE)
echo $(trans SETTING_UP)

${DIR}/scripts/setup/basic.sh

bsddialog --yesno "$(trans ADD_SOURCE_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
1)
    bsddialog --msgbox "$(trans SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)" 0 0
    ;;
0)
    echo $(trans ADD_SOURCE)
    case ${PKG} in
    "zypper")
        case ${TYPE} in
        "Leap")
            chroot ${INSTALL_DIR} /bin/bash -c "zypper mr -da && zypper mr -e repo-openh264"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/distribution/leap/\\\$releasever/repo/oss USTC:OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/distribution/leap/\\\$releasever/repo/non-oss USTC:NON-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/oss USTC:UPDATE-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/non-oss USTC:UPDATE-NON-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/sle USTC:UPDATE-SLE"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/backports USTC:UPDATE-BACKPORTS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ref"
            ;;
        "Tumbleweed")
            chroot ${INSTALL_DIR} /bin/bash -c "zypper mr -da && zypper mr -e repo-openh264"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/tumbleweed/repo/oss USTC:OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/tumbleweed/repo/non-oss USTC:NON-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/tumbleweed/ USTC:UPDATE"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ref"
            ;;
        esac
        ;;
    "dnf")
        case ${TYPE} in
        "Leap")
            sed -e 's|https://download.opensuse.org|https://mirrors.ustc.edu.cn/opensuse|g' \
            -i '.bak' \
            ${INSTALL_DIR}/etc/yum.repos.d/opensuse-leap-oss.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/opensuse-leap-non-oss.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/opensuse-leap-sle-update.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/opensuse-leap-sle-backports-update.repo
            chroot ${INSTALL_DIR} /bin/bash -c "dnf makecache"
            ;;
        "Tumbleweed")
            sed -e 's|https://download.opensuse.org|https://mirrors.ustc.edu.cn/opensuse|g' \
            -i '.bak' \
            ${INSTALL_DIR}/etc/yum.repos.d/opensuse-tumbleweed-oss.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/opensuse-tumbleweed-non-oss.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/opensuse-tumbleweed-update.repo
            chroot ${INSTALL_DIR} /bin/bash -c "dnf makecache"
            ;;
        esac
        ;;
    esac
    ;;
*)
    exit 2
    ;;
esac

if [ "${TYPE}" = "Leap" ] && [ "${PKG}" = "zypper" ];then
    echo $(trans REPLACE_RPM_NDB)
    chroot ${INSTALL_DIR} /bin/bash -c "zypper download rpm"
    chroot ${INSTALL_DIR} /bin/bash -c "find /var/cache/zypp/packages -name "rpm-*.rpm" -exec rpm -ivh --force --nodeps {} \\;"
    chroot ${INSTALL_DIR} /bin/bash -c "rpm --rebuilddb"
fi

bsddialog --yesno "$(trans INSTALL_VIM_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
0)
    echo $(trans INSTALL_VIM)
    case ${PKG} in
    "zypper")
        chroot ${INSTALL_DIR} /bin/bash -c "zypper ref && zypper in vim"
        ;;
    "dnf")
        chroot ${INSTALL_DIR} /bin/bash -c "dnf makecache && dnf install vim"
        ;;
    esac
    ;;
*)
    bsddialog --msgbox "$(trans NOTICE_NO_EDITOR)" 0 0
    ;;
esac

rm -rf ${DIR}/temp

bsddialog --msgbox "$(trans SETUP_COMPLETE)" 0 0

exit 0
