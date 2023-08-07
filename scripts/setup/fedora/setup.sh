#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/fedora/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/fedora/setup_sh/en_US.sh
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
        if [ ${IS_MINIMAL} -eq 1 ]; then
            sed -e 's|^metalink=|#metalink=|g' \
            -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
            -i '.bak' \
            ${INSTALL_DIR}/etc/yum.repos.d/fedora.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/fedora-updates.repo
        else
            sed -e 's|^metalink=|#metalink=|g' \
            -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
            -i '.bak' \
            ${INSTALL_DIR}/etc/yum.repos.d/fedora.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/fedora-modular.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/fedora-updates.repo \
            ${INSTALL_DIR}/etc/yum.repos.d/fedora-updates-modular.repo
        fi
        break
        ;;
    *)
        ;;
    esac
done

echo $(tr SETUP_COMPLETE)
echo $(tr NOTICE_COMMAND)

exit 0
