#!/bin/sh

tr () {
    case $1 in
        "CHECK_START")
            echo "正在检查相关模块"
            ;;
        "ENABLE_LINUX_OR_NOT")
            echo "Linux兼容层并没有启用。是否现在启用它？"
            ;;
        "WARN_START_LINUX")
            echo "警告：系统每次重启都必须执行\"service linux start\"来加载Linux兼容层。"
            ;;
        "CONTINUE_WITHOUT_LINUX_ENABLED_OR_NOT")
            echo "是否保持不启用Linux兼容层？"
            ;;
        "WARN_LINUX_NOT_ENABLED")
            echo "警告：Linux兼容层未启用。"
            ;;
        "ENABLE_LINUX")
            echo "正在启用Linux兼容层"
            ;;      
        "START_LINUX_OR_NOT")
            echo "Linux兼容层看起来并没有被加载。是否现在加载Linux兼容层？"
            ;;
        "ABORT_LINUX_NOT_START")
            echo "终止。Linux兼容层未加载。"
            ;;
        "START_LINUX")
            echo "加载Linux兼容层"
            ;;
        "INSTALL_DBUS_OR_NOT")
            echo "未找到dbus-daemon。是否现在安装？"
            ;;
        "ABORT_DBUS_NOT_INSTALLED")
            echo "终止。dbus没有安装。"
            ;;
        "INSTALL_DBUS")
            echo "正在安装dbus"
            ;;
        "ENABLE_DBUS_OR_NOT")
            echo "dbus没有启用。是否现在启用它？"
            ;;
        "WARN_START_DBUS")
            echo "警告：每次系统重启都必须执行\"service dbus start\"来运行dbus服务。"
            ;;
        "CONTINUE_WITHOUT_DBUS_ENABLED_OR_NOT")
            echo "是否保持dbus不启用？"
            ;;
        "WARN_DBUS_NOT_ENABLED")
            echo "警告：dbus未启用"
            ;;
        "ENABLE_DBUS")
            echo "正在启用dbus服务"
            ;;
        "START_DBUS_OR_NOT")
            echo "dbus服务并未运行。是否现在运行它？"
            ;;
        "ABORT_DBUS_NOT_STARTED")
            echo "终止。dbus服务未运行。"
            ;;
        "START_DBUS")
            echo "正在启动dbus服务"
            ;;
        "LOAD_NULLFS_OR_NOT")
            echo "应该在启动时加载nullfs，是否设置nullfs_load=YES？"
            ;;
        "WARN_LOAD_NULLFS")
            echo "警告：每次系统重启都必须执行\"kldload -v nullfs\"来加载nullfs模块。"
            ;;
        "CONTINUE_WITHOUT_NULLFS_LOADED_OR_NOT")
            echo "是否保持启动时不加载nullfs？"
            ;;
        "WARN_NULLFS_NOT_LOADED")
            echo "警告：nullfs启动时不加载"
            ;;
        "LOAD_NULLFS")
            echo "正在设置启动时加载nullfs"
            ;;
        "LOAD_NULLFS_MODULE_OR_NOT")
            echo "nullfs模块并未被加载。是否现在加载它？"
            ;;
        "ABORT_NULLFS_MODULE_NOT_LOADED")
            echo "终止。nullfs模块未被加载。"
            ;;
        "LOAD_NULLFS_MODULE")
            echo "正在加载nullfs模块"
            ;;
        *)
            echo "$1"
            ;;
    esac
} 
