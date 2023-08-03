#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_DEEPIN_VERSION")
        echo "请选择Deepin版本："
        ;;
    "INSTALLING")
        echo "正在安装："
        ;;
    "CHOOSE_INSTALL_METHORD")
        echo "请选择安装模式："
        ;;
    "METHORD_BOOTSTRAP")
        echo "通过debootstrap安装"
        ;;
    "METHORD_PREBUILT")
        echo "下载预构建的压缩包（非官方发行）"
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
