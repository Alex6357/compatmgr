#!/bin/sh

export DIST_NAME="arch"
export DIST_FULLNAME="Arch Linux"
export DEFAULT_INSTALL_DIR=/compat/${DIST_NAME}
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}

if [ "${METHORD}" = "prebuilt" ]; then
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
        bsddialog --msgbox "$(trans NOTICE_UNINSTALL_KERNEL)" 0 0
        ;;
    i386)
        bsddialog --msgbox "$(trans ARCH_NOT_SUPPORTED)" 0 0
        exit 1
        ;;
    esac
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

if [ "${METHORD}" = "prebuilt" ]; then
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
    tar xvpf ${DIR}/temp/${FILE} -C ${INSTALL_DIR} --numeric-owner ${EXTRA}
fi

if [ "${METHORD}" = "pacman" ]; then
    if ! pkg info -E archlinux-pacman; then
        bsddialog --yesno "$(trans INSTALL_PACMAN_OR_NOT)" 0 0
        ANSWER=${?}
        case ${ANSWER} in
        0)
            echo $(trans INSTALL_PACMAN)
            pkg install -y archlinux-pacman
            ;;
        1)
            bsddialog --msgbox "$(trans ABORT_PACMAN_NOT_INSTALLED)" 0 0
            exit 2
            ;;
        *)
            exit 2
            ;;
        esac
    fi

    if ! pkg info -E archlinux-keyring; then
        bsddialog --yesno "$(trans INSTALL_KEYRING_OR_NOT)" 0 0
        ANSWER=${?}
        case ${ANSWER} in
        0)
            echo $(trans INSTALL_KEYRING)
            pkg install -y archlinux-keyring
            ;;
        1)
            bsddialog --msgbox "$(trans ABORT_KEYRING_NOT_INSTALLED)" 0 0
            exit 2
            ;;
        *)
            exit 2
            ;;
        esac
    fi

    bsddialog --msgbox "$(trans NOTICE_PACMAN_SOURCE)" 0 0
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --refresh-keys
    pacman -Sy
    pacman -S base -r ${INSTALL_DIR}
fi

echo $(trans INSTALL_COMPLETE)
echo $(trans SETTING_UP)

${DIR}/scripts/setup/basic.sh

echo $(trans INIT_KEY)
chroot ${INSTALL_DIR} /bin/bash -c "pacman-key --init"
chroot ${INSTALL_DIR} /bin/bash -c "pacman-key --populate archlinux"

bsddialog --yesno "$(trans ADD_SOURCE_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
1)
    bsddialog --msgbox "$(trans SOURCE_NOT_ADDED)" 0 0
    SOURCE_ADDED=0
    ;;
0)
    echo $(trans ADD_SOURCE)
    SOURCE_ADDED=1
    if [ ${MACHINE_ARCH} = "amd64" ]; then
        sed -i '' \
        -e 's|#Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch|Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch|g' \
        ${INSTALL_DIR}/etc/pacman.d/mirrorlist
    else
        sed -i '' \
        -e 's|Server = http://mirror.archlinuxarm.org|# Server = http://mirror.archlinuxarm.org|g' \
        ${INSTALL_DIR}/etc/pacman.d/mirrorlist
        echo "Server = https://mirrors.ustc.edu.cn/archlinuxarm/\$arch/\$repo" >> ${INSTALL_DIR}/etc/pacman.d/mirrorlist
    fi
    ;;
*)
    exit 2
    ;;
esac

if [ ${SOURCE_ADDED} -eq 1 ]; then
    bsddialog --yesno "$(trans INSTALL_VIM_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    0)
        echo $(trans INSTALL_VIM)
        chroot ${INSTALL_DIR} /bin/bash -c "pacman -Sy --noconfirm && pacman -S --noconfirm vim"
        ;;
    1)
        bsddialog --msgbox "$(trans NOTICE_NO_EDITOR)" 0 0
        ;;
    *)
        exit 2
        ;;
    esac

    bsddialog --yesno "$(trans ADD_ARCHCN_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    1)
        bsddialog --msgbox "$(trans ARCHCN_NOT_ADDED)"
        ;;
    0)
        echo $(trans ADD_ARCHCN)
        cat >>${INSTALL_DIR}/etc/pacman.conf<< EOF
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch
EOF
        chroot ${INSTALL_DIR} /bin/bash -c "pacman -Sy --noconfirm && pacman -S --noconfirm archlinuxcn-keyring && pacman -S --noconfirm fakeroot-tcp"
        ;;
    *)
        exit 2
        ;;
    esac
fi

rm -rf ${DIR}/temp

bsddialog --msgbox "$(trans SETUP_COMPLETE)" 0 0

exit 0
