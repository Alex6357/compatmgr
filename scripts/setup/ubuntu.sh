#!/bin/sh

export DIST_NAME="ubuntu"
VERSION=${VERSION:-"22.04"}
export DIST_FULLNAME="Ubuntu ${VERSION}"
export DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}
METHORD=${METHORD:-"prebuilt"}

if [ "${MACHINE_ARCH}" = "i386" ] && [ "${METHORD}" = "prebuilt" ]; then
    bsddialog --msgbox "$(trans UBUNTU_ARCH_NOT_SUPPORTED_FETCH)" 0 0
    exit 1
fi

case ${VERSION} in
"22.04")
    SUB_VERSION=".5"
    CODENAME="jammy"
    ;;
"20.04")
    SUB_VERSION=".5"
    CODENAME="focal"
    ;;
esac

FILE="ubuntu-base-${VERSION}${SUB_VERSION}-base-${MACHINE_ARCH}.tar.gz"
URL="https://mirrors.ustc.edu.cn/ubuntu-cdimage/ubuntu-base/releases/${CODENAME}/release/${FILE}"

case ${MACHINE_ARCH} in
amd64|i386)
    REPO="https://mirrors.ustc.edu.cn/ubuntu"
    ;;
arm64)
    REPO="https://mirrors.ustc.edu.cn/ubuntu-ports"
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

if [ "${METHORD}" = "debootstrap" ]; then
    check_debootstrap
    STATUS=${?}
    if [ ${STATUS} -ne 0 ]; then
        exit 1
    fi
fi

INSTALL_DIR=$(get_install_dir)
if [ "${INSTALL_DIR}" = "" ]; then
    exit 1
fi

echo ""
echo $(trans NOTICE_INSTALL_DIR)
echo ""

case ${METHORD} in
"debootstrap")
    debootstrap --arch=${MACHINE_ARCH} ${CODENAME} ${INSTALL_DIR} ${REPO}
    STATUS=${?}
    if [ ${STATUS} -ne 0 ]; then
        export STATUS
        bsddialog --msgbox "$(trans INSTALL_FAILED)" 0 0
        exit 3
    fi
    echo $(trans REMOVE_DEBOOTSTRAP_FILES)
    rm -rf ${INSTALL_DIR}/debootstrap
    ;;
"prebuilt")
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
        exit 3
    fi
    ;;
esac

echo $(trans INSTALL_COMPLETE)
echo $(trans SETTING_UP)

${DIR}/scripts/setup/basic.sh

if [ "${METHORD}" = "prebuilt" ]; then
    echo $(trans ADD_APT_CACHE)
    echo "APT::Cache-Start 110663296;" >> ${INSTALL_DIR}/etc/apt/apt.conf.d/01addcache
fi

ask_https(){
    case ${METHORD} in
    "debootstrap")
        sed -i '' 's/http/https/g' ${INSTALL_DIR}/etc/apt/sources.list
        ;;
    "prebuilt")
        bsddialog --yesno "$(trans USE_HTTPS_SOURCES_OR_NOT)" 0 0
        ANSWER=${?}
        case ${ANSWER} in
        0)
            echo $(trans USE_HTTPS_SOURCES)
            chroot ${INSTALL_DIR} /bin/bash -c "apt update && apt install -y ca-certificates"
            sed -i '' 's/http/https/g' ${INSTALL_DIR}/etc/apt/sources.list
            ;;
        *)
            bsddialog --msgbox "$(trans HTTPS_SOURCES_NOT_USED)" 0 0
            ;;
        esac
    esac
}

bsddialog --yesno "$(trans ADD_SOURCE_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
1)
    if [ "${METHORD}" = "prebuilt" ]; then
        bsddialog --msgbox "$(trans SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)" 0 0
    else
        case ${VERSION} in
        "22.04")
            bsddialog --msgbox "$(trans UBUNTU_22_SOURCE_NOT_ADDED)" 0 0
            ;;
        "20.04")
            bsddialog --msgbox "$(trans UBUNTU_20_SOURCE_NOT_ADDED)" 0 0
            ;;
        esac
    fi
    ;;
0)
    echo $(trans ADD_SOURCE)
    case ${VERSION} in 
    "22.04")
        cat >${INSTALL_DIR}/etc/apt/sources.list<< EOF
deb http://mirrors.ustc.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
EOF
        ;;
    "20.04")
        cat >${INSTALL_DIR}/etc/apt/sources.list<< EOF
deb http://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse

## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu focal partner
# deb-src http://archive.canonical.com/ubuntu focal partner
EOF
        ;;
    esac
    ask_https
    ;;
*)
    exit 2
    ;;
esac

if [ "${METHORD}" = "prebuilt" ]; then
    bsddialog --yesno "$(trans INSTALL_VIM_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    0)
        echo $(trans INSTALL_VIM)
        chroot ${INSTALL_DIR} /bin/bash -c "apt update && apt install -y vim"
        ;;
    *)
        bsddialog --msgbox "$(trans NOTICE_NO_EDITOR)" 0 0
        ;;
    esac
fi

rm -rf ${DIR}/temp

bsddialog --msgbox "$(trans SETUP_COMPLETE)" 0 0

exit 0
