#!/bin/sh

tr () {
    case ${1} in
    "SETUP_COMPLETE")
        echo "配置全部完成"
        ;;
    "NOTICE_COMMAND")
        echo "你现在可以执行\"chroot ${INSTALL_DIR} /bin/bash\"来切换到 ${DIST_FULLNAME}"
        ;;
    *)
        echo ${1}
        ;;
    esac
}
