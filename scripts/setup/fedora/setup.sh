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

echo $(trans SETUP_COMPLETE)
echo $(trans NOTICE_COMMAND)

exit 0
