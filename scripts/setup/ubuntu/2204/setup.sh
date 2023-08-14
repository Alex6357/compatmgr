#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/ubuntu/2204/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/ubuntu/2204/setup_sh/en_US.sh
fi

IS_FETCH=${IS_FETCH:-0}

${DIR}/scripts/setup/basic.sh

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
deb http://mirrors.ustc.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse

deb http://mirrors.ustc.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
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
