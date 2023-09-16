#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/arch/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/arch/setup_sh/en_US.sh
fi

IS_MINIMAL=${IS_MINIMAL:-0}

${DIR}/scripts/setup/basic.sh

echo $(trans INIT_KEY)
chroot ${INSTALL_DIR} /bin/bash -c "pacman-key --init"
chroot ${INSTALL_DIR} /bin/bash -c "pacman-key --populate archlinux"

while true; do
    echo -n "$(trans ADD_SOURCE_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(trans SOURCE_NOT_ADDED)
        SOURCE_ADDED=0
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
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
        break
        ;;
    *)
        ;;
    esac
done

if [ ${SOURCE_ADDED} -eq 1 ]; then
    while true; do
        echo -n "$(trans INSTALL_VIM_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans INSTALL_VIM)
            chroot ${INSTALL_DIR} /bin/bash -c "pacman -Sy --noconfirm && pacman -S --noconfirm vim"
            break
            ;;
        [Nn][Oo]|[Nn])
            echo $(trans NOTICE_NO_EDITOR)
            break
            ;;
        *)
            ;;
        esac
    done
fi

if [ ${SOURCE_ADDED} -eq 1 ]; then
    while true; do
        echo -n "$(trans ADD_ARCHCN_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans ARCHCN_NOT_ADDED)
            break
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans ADD_ARCHCN)
            cat >>${INSTALL_DIR}/etc/pacman.conf<< EOF
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch
EOF
            chroot ${INSTALL_DIR} /bin/bash -c "pacman -Sy --noconfirm && pacman -S --noconfirm archlinuxcn-keyring && pacman -S --noconfirm fakeroot-tcp"
            break
            ;;
        *)
            ;;
        esac
    done
fi

echo $(trans SETUP_COMPLETE)
echo $(trans NOTICE_COMMAND)

exit 0
