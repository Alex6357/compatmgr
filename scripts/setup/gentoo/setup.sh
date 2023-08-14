#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/gentoo/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/gentoo/setup_sh/en_US.sh
fi

IS_MINIMAL=${IS_MINIMAL:-0}

${DIR}/scripts/setup/basic.sh

echo $(tr ADD_FEATURES)
echo "FEATURES=\"-ipc-sandbox -mount-sandbox -network-sandbox -pid-sandbox -xattr -sandbox -usersandbox\"" >> ${INSTALL_DIR}/etc/portage/make.conf

echo $(tr COPY_REPO_CONFIG)
cp ${INSTALL_DIR}/usr/share/portage/config/repos.conf ${INSTALL_DIR}/etc/portage/repos.conf

while true; do
    echo -n "$(tr ADD_SOURCE_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(tr SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE)
        mkdir -p ${INSTALL_DIR}/var/db/repos/gentoo
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(tr ADD_SOURCE)
        echo "GENTOO_MIRRORS=\"https://mirrors.ustc.edu.cn/gentoo/\"" >> ${INSTALL_DIR}/etc/portage/make.conf
        sed -i '' \
        -e 's/rsync.gentoo.org/rsync.mirrors.ustc.edu.cn/g' \
        -e 's|/var/db/repos/gentoo|/var/db/repos/ustc|g' \
        ${INSTALL_DIR}/etc/portage/repos.conf
        mkdir -p ${INSTALL_DIR}/var/db/repos/ustc
        break
        ;;
    *)
        ;;
    esac
done

echo $(tr SETUP_COMPLETE)
echo $(tr NOTICE_COMMAND)

exit 0
