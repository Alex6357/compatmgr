#!/bin/sh

tr () {
    case ${1} in
    "ENTER_DIR")
        echo "请输入Linux兼容层所在目录："
        ;;
    "WARN_NOT_LINUX")
        echo "警告：此目录看起来不是Linux根目录，是否继续？"
        ;;
    "WARN_REMOVE")
        echo "警告：此目录会被彻底删除，是否继续？"
        ;;
    "ABORT")
        echo "终止。"
        ;;
    "DONE")
        echo "已完成。"
        ;;
    *)
        echo ${1}
        ;;
    esac
}