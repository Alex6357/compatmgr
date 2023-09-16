#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

IS_MINIMAL=${IS_MINIMAL:-0}

${DIR}/scripts/setup/basic.sh

while true; do
    echo -n "$(trans ADD_SOURCE_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(trans SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(trans ADD_SOURCE)
        if [ ${IS_DNF} -eq 0 ]; then
            chroot ${INSTALL_DIR} /bin/bash -c "zypper mr -da && zypper mr -e repo-openh264"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/tumbleweed/repo/oss USTC:OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/tumbleweed/repo/non-oss USTC:NON-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/tumbleweed/ USTC:UPDATE"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ref"
        else
            sed -e 's|https://download.opensuse.org|https://mirrors.ustc.edu.cn/opensuse|g' \
            -i '.bak' \
            /etc/yum.repos.d/opensuse-tumbleweed-oss.repo \
            /etc/yum.repos.d/opensuse-tumbleweed-non-oss.repo \
            /etc/yum.repos.d/opensuse-tumbleweed-update.repo
            chroot ${INSTALL_DIR} /bin/bash -c "dnf makecache"
        fi
        break
        ;;
    *)
        ;;
    esac
done


while true; do
    echo -n "$(trans INSTALL_VIM_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(trans INSTALL_VIM)
        if [ ${IS_DNF} -eq 0 ]; then
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ref && zypper in vim"
        else
            chroot ${INSTALL_DIR} /bin/bash -c "dnf makecache && dnf install vim"
        fi
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

echo $(trans SETUP_COMPLETE)
echo $(trans NOTICE_COMMAND)

exit 0
