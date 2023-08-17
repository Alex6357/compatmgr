#!/bin/sh

tr () {
    case $1 in
    "ARCH_NOT_SUPPORTED")
        echo "错误：你的架构 $(sysctl -n hw.machine_arch) 不支持Linux兼容层。"
        ;;
    "NOT_RUN_BY_ROOT")
        echo "错误：必须以root身份运行compatmgr"
        ;;
    "WELCOME")
        echo "欢迎使用FreeBSD Linux兼容层管理器！ 作者：Alex11"
        ;;
    "PLEASE_SELECT")
        echo "请选择："
        ;;
    "CHOICE_CHECK")
        echo "运行环境检查"
        ;;
    "CHOICE_INSTALL")
        echo "安装兼容层"
        ;;
    "CHOICE_REMOVE")
        echo "移除兼容层"
        ;;
    "CHOICE_EXIT")
        echo "退出"
        ;;
    "REQUIRE_CHOICE")
        echo "输入选项："
        ;;
    "INSTALL_SELECT")
        echo "选择你想安装的发行版："
        ;;
    "CHOICE_RETURN")
        echo "返回上一级"
        ;;
    "REMOVE_SELECT")
        echo "选择想要移除的兼容层："
        ;;
    "GOODBYE")
        echo "再见！"
        ;;
    "CHECK_SUCCESS")
        echo "环境检查通过"
        ;;
    "CHECK_FAILED_LINUX_NOT_STARTED")
        echo "环境检查失败，Linux兼容层未加载"
        ;;
    "CHECK_FAILED_DBUS_NOT_INSTALLED")
        echo "环境检查失败，dbus未安装"
        ;;
    "CHECK_FAILED_DBUS_NOT_STARTED")
        echo "环境检查失败，dbus服务未开启"
        ;;
    "CHECK_FAILED_NULLFS_NOT_LOADED")
        echo "环境检查失败，nullfs模块未加载"
        ;;
    *)
        echo "$1"
        ;;
    esac
}
