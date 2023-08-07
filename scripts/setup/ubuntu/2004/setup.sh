#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/ubuntu/2004/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/ubuntu/2004/setup_sh/en_US.sh
fi

${IS_FETCH:-0}

while true; do
    echo -n "$(tr USE_ALI_DNS_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo "USE_LOCAL_DNS"
        if [ ${IS_FETCH} -eq 1 ]; then
            cp /etc/resolv.conf ${INSTALL_DIR}/etc/resolv.conf
        fi
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

if [ ${IS_FETCH} -eq 1 ]; then
    echo $(tr ADD_APT_CACHE)
    echo "APT::Cache-Start 110663296;" >> ${INSTALL_DIR}/etc/apt/apt.conf.d/01addcache
fi

while true; do
    echo -n "$(tr ADD_SOURCE_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        if [ ${IS_FETCH} -eq 1 ]; then
            echo $(tr SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)
        else
            echo $(tr SOURCE_NOT_ADDED_MAIN_ONLY)
        fi
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr ADD_SOURCE)
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
        if [ ${IS_FETCH} -eq 0 ]; then
            sed -i '' 's/http/https/g' ${INSTALL_DIR}/etc/apt/sources.list
        else
            while true; do
                echo -n "$(tr USE_HTTPS_SOURCES_OR_NOT)[Y|n]: "
                read ANSWER
                case ${ANSWER} in
                [Yy][Ee][Ss]|[Yy]|"")
                    echo $(tr USE_HTTPS_SOURCES)
                    chroot ${INSTALL_DIR} /bin/bash -c "apt update && apt install -y ca-certificates"
                    sed -i '' 's/http/https/g' ${INSTALL_DIR}/etc/apt/sources.list
                    break
                    ;;
                [Nn][Oo]|[Nn])
                    echo $(tr HTTPS_SOURCES_NOT_USED)
                    break
                    ;;
                *)
                    ;;
                esac
            done
        fi
        break
        ;;
    *)
        ;;
    esac
done

if [ ${IS_FETCH} -eq 1 ]; then
    while true; do
        echo -n "$(tr INSTALL_VIM_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(tr INSTALL_VIM)
            chroot ${INSTALL_DIR} /bin/bash -c "apt update && apt install -y vim"
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

echo $(tr SETUP_COMPLETE)
echo $(tr NOTICE_COMMAND)

exit 0
