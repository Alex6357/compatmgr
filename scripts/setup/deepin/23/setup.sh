#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/scripts/setup/deepin/23/setup_sh/zh_CN.sh
else
    . ${DIR}/i18n/scripts/setup/deepin/23/setup_sh/en_US.sh
fi

${DIR}/scripts/setup/basic.sh

echo $(tr SETUP_COMPLETE)
echo $(tr NOTICE_COMMAND)

exit 0
