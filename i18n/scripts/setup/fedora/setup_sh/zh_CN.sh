#!/bin/sh

tr () {
    case ${1} in
    "ADD_SOURCE_OR_NOT")
        echo "是否配置全部ustc源？"
        ;;
    "SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE")
        echo "ustc源未配置，但官方源可用。"
        ;;
    "ADD_SOURCE")
        echo "正在配置ustc源"
        ;;
    "USE_HTTPS_SOURCES_OR_NOT")
        echo "是否使用https源？这将会安装ca-certificates"
        ;;
    "USE_HTTPS_SOURCES")
        echo "正在配置https源"
        ;;
    "HTTPS_SOURCES_NOT_USED")
        echo "正在使用http源"
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
