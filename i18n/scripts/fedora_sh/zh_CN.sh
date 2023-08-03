#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_FEDORA_TYPE")
        echo "请选择Fedora类型："
        ;;
    "MINIMAL_NOT_RECOMMENDED")
        echo "（不推荐，没有dnf等包管理器）"
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
