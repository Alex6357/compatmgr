#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/debian/11/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/debian/11/setup_sh/en_US.sh
fi

${DIR}/scripts/setup/basic.sh

while true; do
    echo -n "$(tr ADD_SOURCE_OR_NOT)[Y|n]: "
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
