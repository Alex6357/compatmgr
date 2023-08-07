#!/bin/sh

tr () {
    case ${1} in
    "USE_ALI_DNS_OR_NOT")
        echo "是否使用阿里DNS？如果否，则默认使用本地resolv.conf文件。"
        ;;
    "USE_LOCAL_DNS")
        echo "正在使用本地DNS文件："
        ;;
    "USE_ALI_DNS")
        echo "正在配置阿里DNS"
        ;;
    "ADD_FSTAB_OR_NOT")
        echo "是否自动配置fstab？"
        ;;
    "WARN_MOUNT_MANUALLY")
        echo "警告：fstab未配置，要想正常使用兼容层，每次系统重启都必须手动挂载相关文件系统。"
        ;;
    "CONTINUE_WITHOUT_FSTAB_ADDED")
        echo "是否继续？"
        ;;
    "WARN_FSTAB_NOT_ADDED")
        echo "警告：fstab未配置，兼容层可能无法正常使用。你可以在/etc/fstab中添加以下配置并使用\"mount -al\"进行挂载。"
        ;;
    "ADD_FSTAB")
        echo "正在配置fstab"
        ;;
    "ADD_SOURCE_OR_NOT")
        echo "是否配置全部ustc源？"
        ;;
    "SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE")
        echo "ustc源未配置，但官方源可用。"
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
