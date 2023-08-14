#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/fedora/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/fedora/setup_sh/en_US.sh
fi

IS_MINIMAL=${IS_MINIMAL:-0}

${DIR}/scripts/setup/basic.sh

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
