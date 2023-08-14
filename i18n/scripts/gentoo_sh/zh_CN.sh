#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_GENTOO_TYPE")
        echo "请选择Gentoo类型："
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
