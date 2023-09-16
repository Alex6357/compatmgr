#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

${DIR}/scripts/setup/basic.sh

echo $(trans SETUP_COMPLETE)
echo $(trans NOTICE_COMMAND)

exit 0
