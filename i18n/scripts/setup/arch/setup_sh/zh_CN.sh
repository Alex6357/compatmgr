#!/bin/sh

tr () {
    case ${1} in
    "INIT_KEY")
        echo "正在初始化pacman密钥"
        ;;
    "ADD_SOURCE_OR_NOT")
        echo "是否配置全部ustc源？"
        ;;
    "SOURCE_NOT_ADDED")
        echo "ustc源未配置，你可能需要手动配置软件源。"
        ;;
    "ADD_SOURCE")
        echo "正在配置ustc源"
        ;;
    "INSTALL_VIM_OR_NOT")
        echo "兼容层没有文本编辑器。是否安装vim？"
        ;;
    "INSTALL_VIM")
        echo "正在安装vim"
        ;;
    "NOTICE_NO_EDITOR")
        echo "注意：你可以稍后安装文本编辑器或使用FreeBSD中的文本编辑器。"
        ;;
    "ADD_ARCHCN_OR_NOT")
        echo "是否添加 Arch Linux CN 源？"
        ;;
    "ARCHCN_NOT_ADDED")
        echo "未添加 Arch Linux CN 源"
        ;;
    "ADD_ARCHCN")
        echo "正在添加 Arch Linux CN 源"
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
