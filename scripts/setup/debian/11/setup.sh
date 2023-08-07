#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/debian/11/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/debian/11/setup_sh/en_US.sh
fi

while true; do
    echo -n "$(tr USE_ALI_DNS_OR_NOT)[Y|n]"
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(tr USE_LOCAL_DNS)
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
    echo -n "$(tr ADD_FSTAB_OR_NOT)[Y|n]"
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(tr WARN_MOUNT_MANUALLY)
        while true; do
            echo -n "$(tr CONTINUE_WITHOUT_FSTAB_ADDED)[y|N]"
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
    echo -n "$(tr ADD_SOURCE_OR_NOT)[Y|n]"
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(tr SOURCE_NOT_ADDED)
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr ADD_SOURCE)
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
        break
        ;;
    *)
        ;;
    esac
done

echo $(tr SETUP_COMPLETE)
echo $(tr NOTICE_COMMAND)

exit 0
