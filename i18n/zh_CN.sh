#!/bin/sh

trans () {
    case $1 in

    # compatmgr.sh
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

    # scripts/check.sh
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

    # scripts/debian.sh
    "CHOOSE_DEBIAN_VERSION")
        echo "请选择Debian版本："
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
        echo "下载预构建的压缩包（非官方发行！）"
        ;;
    "RETURN")
        echo "返回上一级"
        ;;

    # scripts/deepin.sh
    "CHOOSE_DEEPIN_VERSION")
        echo "请选择Deepin版本："
        ;;

    # scripts/fedora.sh
    "CHOOSE_FEDORA_TYPE")
        echo "请选择Fedora类型："
        ;;
    "MINIMAL_NOT_RECOMMENDED")
        echo "（不推荐，没有dnf等包管理器）"
        ;;

    # scripts/gentoo.sh
    "CHOOSE_GENTOO_TYPE")
        echo "请选择Gentoo类型："
        ;;

    # scripts/suse.sh
    "CHOOSE_SUSE_VERSION")
        echo "请选择openSUSE版本："
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

    # scripts/ubuntu.sh
    "CHOOSE_UBUNTU_VERSION")
        echo "请选择Ubuntu版本："
        ;;
    "METHORD_UBUNTU_PREBUILT")
        echo "从ustc下载预构建的压缩包"
        ;;

    # scripts/remove.sh
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

    # scripts/fetch/arch.sh
    "NOTICE_UNINSTALL_KERNEL")
        echo "注意：Arch Linux ARM 包含内核和initramfs，这在Linux兼容层中无用。"
        echo "你可以稍后卸载或删除内核和initramfs。"
        ;;
    "ARCH_NOT_SUPPORT")
        echo "Arch Linux 不支持 i386"
        ;;
    "CHANGE_INSTALL_DIR_OR_NOT")
        echo "选择安装位置"
        ;;
    "CONFIRM_INSTALL_DIR_OR_NOT")
        echo "是否确认安装到此位置？"
        ;;
    "WARN_DIR_NOT_EMPTY")
        echo "此路径非空，是否强制安装到此？（可能破坏原有文件！）"
        ;;
    "NOTICE_INSTALL_DIR")
        echo "${DIST_FULLNAME} 将被安装至 ${INSTALL_DIR}"
        ;;
    "INSTALL_COMPLETE")
        echo "${DIST_FULLNAME} 安装完成"
        ;;
    "INSTALL_FAILED_FETCH")
        echo "安装失败。fetch返回了${STATUS}"
        ;;
    "INSTALL_FAILED_TAR")
        echo "安装失败。tar返回了${STATUS}"
        ;;
    "SETTING_UP")
        echo "正在配置 ${DIST_FULLNAME}"
        ;;

    # scripts/fetch/debian/bootstrap.sh
    "INSTALL_DEBOOTSTRAP_OR_NOT")
        echo "debootstrap未安装。是否现在安装？"
        ;;
    "INSTALL_FAILED_DEBOOTSTRAP_NOT_INSTALLED")
        echo "安装失败。debootstrap未安装。"
        ;;
    "INSTALL_DEBOOTSTRAP")
        echo "正在安装debootstrap"
        ;;
    "INSTALL_FAILED")
        echo "安装失败。debootstrap返回了${STATUS}"
        ;;

    # scripts/fetch/deepin/bootstrap.sh
    "DEEPIN_ARCH_NOT_SUPPORTED")
        echo "Deepin 不支持 ARM64。"
        ;;

    # scripts/fetch/fedora.sh
    "FEDORA_ARCH_NOT_SUPPORTED")
        echo "Fedora 不支持 i386"
        ;;

    # scripts/fetch/kali/bootstrap.sh
    "REMOVE_DEBOOTSTRAP_FILES")
        echo "正在移除debootstrap文件"
        ;;

    # scripts/fetch/suse.sh
    "OPENSUSE_ARCH_NOT_SUPPORTED")
        echo "openSUSE 不支持 i386"
        ;;

    # scripts/fetch/ubuntu/bootstrap.sh
    "UBUNTU_ARCH_NOT_SUPPORTED_FETCH")
        echo "Ubuntu i386 不支持以fetch的方式安装。你可以用debootstrap安装。"
        ;;

    # scripts/setup/basic.sh
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

    # scripts/setup/arch.sh
    "INIT_KEY")
        echo "正在初始化pacman密钥"
        ;;
    "ADD_SOURCE_OR_NOT")
        echo "是否配置全部ustc源？"
        ;;
    "SOURCE_NOT_ADDED")
        echo "ustc源未配置，你可能需要手动配置软件源。"
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
    "ADD_ARCHCN_OR_NOT")
        echo "是否添加 Arch Linux CN 源？"
        ;;
    "ARCHCN_NOT_ADDED")
        echo "未添加 Arch Linux CN 源"
        ;;
    "ADD_ARCHCN")
        echo "正在添加 Arch Linux CN 源"
        ;;
    "SETUP_COMPLETE")
        echo "配置全部完成"
        ;;
    "NOTICE_COMMAND")
        echo "你现在可以执行\"chroot ${INSTALL_DIR} /bin/bash\"来切换到 ${DIST_FULLNAME}"
        ;;

    # scripts/setup/debian.sh
    "DEBIAN_12_SOURCE_NOT_ADDED")
        echo "镜像源未配置，仅有bookworm main可用"
        ;;
    "DEBIAN_11_SOURCE_NOT_ADDED")
        echo "镜像源未配置，仅有bullseye main可用"
        ;;

    # scripts/setup/fedora.sh
    "SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE")
        echo "ustc源未配置，但官方源可用。"
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

    # scripts/setup/gentoo.sh
    "ADD_FEATURES")
        echo "正在为Gentoo添加make feature"
        ;;
    "COPY_REPO_CONFIG")
        echo "正在复制repos.conf"
        ;;

    # scripts/setup/kali.sh
        "KALI_SOURCE_NOT_ADDED")
        echo "镜像源未配置，仅有kali-rolling main可用"
        ;;

    # scripts/setup/suse.sh
        "REPLACE_RPM_NDB")
        echo "正在将rpm-ndb替换为rpm以避免错误"
        ;;

    # scripts/setup/ubuntu.sh
    "ADD_APT_CACHE")
        echo "添加配置“APT::Cache-Start 110663296;”以避免错误"
        ;;
    "UBUNTU_22_SOURCE_NOT_ADDED")
        echo "ustc源未配置，仅jammy main可用。"
        ;;
    "UBUNTU_20_SOURCE_NOT_ADDED")
        echo "ustc源未配置，仅focal main可用。"
        ;;

    *)
        echo "$1"
        ;;
    esac
}
