#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/debian/12/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/debian/12/setup_sh/en_US.sh
fi

${DIR}/scripts/setup/basic.sh

while true; do
    echo -n "$(trans ADD_SOURCE_OR_NOT)[Y|n]: "
    read ANSWER
    case ${ANSWER} in
    [Nn][Oo]|[Nn])
        echo $(trans SOURCE_NOT_ADDED)
        break
        ;;
    [Yy][Ee][Ss]|[Yy]|"")
        echo $(trans ADD_SOURCE)
        cat >${INSTALL_DIR}/etc/apt/sources.list.d/debian.sources<< EOF
Types: deb
URIs: https://mirrors.ustc.edu.cn/debian
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: https://mirrors.ustc.edu.cn/debian-security
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb-src
URIs: https://mirrors.ustc.edu.cn/debian
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb-src
URIs: https://mirrors.ustc.edu.cn/debian-security
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
        rm ${INSTALL_DIR}/etc/apt/sources.list
        break
        ;;
    *)
        ;;
    esac
done

echo $(trans SETUP_COMPLETE)
echo $(trans NOTICE_COMMAND)

exit 0
