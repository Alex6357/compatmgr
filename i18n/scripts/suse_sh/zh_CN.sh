#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_SUSE_VERSION")
        echo "请选择openSUSE版本："
        ;;
    "INSTALLING")
        echo "正在安装："
        ;;
    "CHOOSE_INSTALL_TYPE")
        echo "请选择安装种类："
        ;;
    "TYPE_ZYPPER")
        echo "使用zypper包管理器的openSUSE"
        ;;
    "TYPE_DNF")
        echo "使用dnf包管理器的openSUSE"
        ;;
    "RETURN")
        echo "返回上一级"
        ;;
    "REQUIRE_CHOICE")
        echo "输入选项："
        ;;
    *)
        echo ${1}
        ;;
    esac
}
