#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/remove_sh/zh_CN.sh
else
    . ${DIR}/i18n/remove_sh/en_US.sh
fi

echo -n "$(trans ENTER_DIR)"
read DIRECTORY
if ! [ -f ${DIRECTORY}/etc/os-release ]; then
    echo -n "$(trans WARN_NOT_LINUX)[yes|NO]: "
    read ANSWER
    case ${ANSWER} in
    [Yy][Ee][Ss])
        ;;
    *)
        echo "$(trans ABORT)"
        exit 1
        ;;
    esac
fi

echo "$(trans WARN_REMOVE)[yes|NO]: "
read ANSWER
case ${ANSWER} in
[Yy][Ee][Ss])
    ;;
*)
    echo "$(trans ABORT)"
    exit 1
    ;;
esac

rm -rf ${DIRECTORY}

sed -i '' -e "|${DIRECTORY}/|d" /etc/fstab

echo "$(trans DONE)"
