#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_DEBIAN_VERSION")
        echo "请选择Ubuntu版本："
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
        echo "从ustc下载预构建的压缩包"
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