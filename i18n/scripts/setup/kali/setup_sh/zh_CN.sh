#!/bin/sh

tr () {
    case ${1} in
    "ADD_SOURCE_OR_NOT")
        echo "是否配置全部ustc源？"
        ;;
    "SOURCE_NOT_ADDED")
        echo "镜像源未配置，仅有kali-rolling main可用"
        ;;
    "ADD_SOURCE")
        echo "正在配置ustc源"
        ;;
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
