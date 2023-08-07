#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/suse/leap/15.5/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/suse/leap/15.5/setup_sh/en_US.sh
fi

IS_MINIMAL=${IS_MINIMAL:-0}

while true; do
    echo -n "$(tr USE_ALI_DNS_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo "USE_LOCAL_DNS"
        cp /etc/resolv.conf ${INSTALL_DIR}/etc/resolv.conf
        grep nameserver ${INSTALL_DIR}/etc/resolv.conf
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr USE_ALI_DNS)
        echo "nameserver 223.5.5.5" > ${INSTALL_DIR}/etc/resolv.conf
        break
        ;;
    *)
        ;;
    esac
done

while true; do
    echo -n "$(tr ADD_FSTAB_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(tr WARN_MOUNT_MANUALLY)
        while true; do
            echo -n "$(tr CONTINUE_WITHOUT_FSTAB_ADDED)[y|N]: "
            read ANSWER
            case ${ANSWER} in
            [Yy][Ee][Ss]|[Yy])
                echo $(tr WARN_FSTAB_NOT_ADDED)
                echo "devfs	${INSTALL_DIR}/dev	devfs	rw,late	0	0"
                echo "tmpfs	${INSTALL_DIR}/dev/shm	tmpfs	rw,late,size=1g,mode=1777	0	0"
                echo "fdescfs	${INSTALL_DIR}/dev/fd	fdescfs	rw,late,linrdlnk	0	0"
                echo "linprocfs	${INSTALL_DIR}/proc	linprocfs	rw,late	0	0"
                echo "linsysfs	${INSTALL_DIR}/sys	linsysfs	rw,late	0	0"
                echo "/tmp	${INSTALL_DIR}/tmp	nullfs	rw,late	0	0"
                echo "#/home	${INSTALL_DIR}/home	nullfs	rw,late	0	0"
                break
                ;;
            [Nn][Oo]|[Nn]|"")
                echo $(tr ADD_FSTAB)
                echo "devfs	${INSTALL_DIR}/dev	devfs	rw,late	0	0" >> /etc/fstab
                echo "tmpfs	${INSTALL_DIR}/dev/shm	tmpfs	rw,late,size=1g,mode=1777	0	0" >> /etc/fstab
                echo "fdescfs	${INSTALL_DIR}/dev/fd	fdescfs	rw,late,linrdlnk	0	0" >> /etc/fstab
                echo "linprocfs	${INSTALL_DIR}/proc	linprocfs	rw,late	0	0" >> /etc/fstab
                echo "linsysfs	${INSTALL_DIR}/sys	linsysfs	rw,late	0	0" >> /etc/fstab
                echo "/tmp	${INSTALL_DIR}/tmp	nullfs	rw,late	0	0" >> /etc/fstab
                echo "#/home	${INSTALL_DIR}/home	nullfs	rw,late	0	0" >> /etc/fstab
                mount -al
                break
                ;;
            *)
                ;;
            esac
        done
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr ADD_FSTAB)
        echo "devfs	${INSTALL_DIR}/dev	devfs	rw,late	0	0" >> /etc/fstab
        echo "tmpfs	${INSTALL_DIR}/dev/shm	tmpfs	rw,late,size=1g,mode=1777	0	0" >> /etc/fstab
        echo "fdescfs	${INSTALL_DIR}/dev/fd	fdescfs	rw,late,linrdlnk	0	0" >> /etc/fstab
        echo "linprocfs	${INSTALL_DIR}/proc	linprocfs	rw,late	0	0" >> /etc/fstab
        echo "linsysfs	${INSTALL_DIR}/sys	linsysfs	rw,late	0	0" >> /etc/fstab
        echo "/tmp	${INSTALL_DIR}/tmp	nullfs	rw,late	0	0" >> /etc/fstab
        echo "#/home	${INSTALL_DIR}/home	nullfs	rw,late	0	0" >> /etc/fstab
        mount -al
        break
        ;;
    *)
        ;;
    esac
done


while true; do
    echo -n "$(tr ADD_SOURCE_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(tr SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr ADD_SOURCE)
        if [ ${IS_DNF} -eq 0 ]; then
            chroot ${INSTALL_DIR} /bin/bash -c "zypper mr -da && zypper mr -e repo-openh264"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/distribution/leap/\\\$releasever/repo/oss USTC:OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/distribution/leap/\\\$releasever/repo/non-oss USTC:NON-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/oss USTC:UPDATE-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/non-oss USTC:UPDATE-NON-OSS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/sle USTC:UPDATE-SLE"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ar -fcg https://mirrors.ustc.edu.cn/opensuse/update/leap/\\\$releasever/backports USTC:UPDATE-BACKPORTS"
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ref"
        else
            sed -e 's|https://download.opensuse.org|https://mirrors.ustc.edu.cn/opensuse|g' \
            -i '.bak' \
            /etc/yum.repos.d/opensuse-leap-oss.repo \
            /etc/yum.repos.d/opensuse-leap-non-oss.repo \
            /etc/yum.repos.d/opensuse-leap-sle-update.repo \
            /etc/yum.repos.d/opensuse-leap-sle-backports-update.repo
            chroot ${INSTALL_DIR} /bin/bash -c "dnf makecache"
        fi
        break
        ;;
    *)
        ;;
    esac
done

if [ ${IS_DNF} -eq 0 ];then
    echo $(tr REPLACE_RPM_NDB)
    chroot ${INSTALL_DIR} /bin/bash -c "zypper download rpm"
    chroot ${INSTALL_DIR} /bin/bash -c "find /var/cache/zypp/packages -name "rpm-*.rpm" -exec rpm -ivh --force --nodeps {} \\;"
    chroot ${INSTALL_DIR} /bin/bash -c "rpm --rebuilddb"
fi

while true; do
    echo -n "$(tr INSTALL_VIM_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr INSTALL_VIM)
        if [ ${IS_DNF} -eq 0 ]; then
            chroot ${INSTALL_DIR} /bin/bash -c "zypper ref && zypper in vim"
        else
            chroot ${INSTALL_DIR} /bin/bash -c "dnf makecache && dnf install vim"
        fi
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

echo $(tr SETUP_COMPLETE)
echo $(tr NOTICE_COMMAND)

exit 0
