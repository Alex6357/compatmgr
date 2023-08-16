#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/arch/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/arch/setup_sh/en_US.sh
fi

IS_MINIMAL=${IS_MINIMAL:-0}

${DIR}/scripts/setup/basic.sh

echo $(tr INIT_KEY)
chroot ${INSTALL_DIR} /bin/bash -c "pacman-key --init"
chroot ${INSTALL_DIR} /bin/bash -c "pacman-key --populate archlinux"

while true; do
    echo -n "$(tr ADD_SOURCE_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(tr SOURCE_NOT_ADDED)
        SOURCE_ADDED=0
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr ADD_SOURCE)
        SOURCE_ADDED=1
        sed -i '' \
        -e 's|#Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch|Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch|g' \
        ${INSTALL_DIR}/etc/pacman.d/mirrorlist
        break
        ;;
    *)
        ;;
    esac
done

if [ ${SOURCE_ADDED} -eq 1 ]; then
    while true; do
        echo -n "$(tr INSTALL_VIM_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(tr INSTALL_VIM)
            chroot ${INSTALL_DIR} /bin/bash -c "pacman -Sy --noconfirm && pacman -S --noconfirm vim"
            break
            ;;
        [Nn][Oo]|[Nn])
            echo $(tr NOTICE_NO_EDITOR)
            break
            ;;
        *)
            ;;
        esac
    done
fi

if [ ${SOURCE_ADDED} -eq 1 ]; then
    while true; do
        echo -n "$(tr ADD_ARCHCN_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(tr ARCHCN_NOT_ADDED)
            break
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(tr ADD_ARCHCN)
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

echo $(tr SETUP_COMPLETE)
echo $(tr NOTICE_COMMAND)

exit 0
