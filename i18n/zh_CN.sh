#!/bin/sh

trans () {
    case $1 in

    # compatmgr.sh
    "BSDDIALOG_NOT_FOUND")
        echo "错误：没有找到 bsddialog。他默认包含在 FreeBSD 13.2 或 14.0 及以上版本。"
        echo "如果你正在运行较老版本的 FreeBSD，你可以尝试安装 devel/bsddialog。"
        ;;
    "NOT_RUN_BY_ROOT")
        echo "错误：必须以 root 身份运行 compatmgr"
        ;;
    "ARCH_NOT_SUPPORTED")
        echo "错误：你的架构 $(sysctl -n hw.machine_arch) 不支持 Linux 兼容层。"
        ;;
    "EXIT")
        echo "退出"
        ;;
    "OK")
        echo "确认"
        ;;
    "WELCOME")
        echo "欢迎使用 FreeBSD Linux 兼容层管理器！  作者：Alex11"
        ;;
    "CHOICE_CHECK")
        echo "运行环境检查"
        ;;
    "CHOICE_CHECK_DESCRIPTION")
        echo "检查当前环境是否能够安装 Linux 兼容层"
        ;;
    "CHOICE_INSTALL")
        echo "安装兼容层"
        ;;
    "CHOICE_INSTALL_DESCRIPTION")
        echo "安装新的 Linux 兼容层"
        ;;
    "CHOICE_REMOVE")
        echo "移除兼容层"
        ;;
    "CHOICE_REMOVE_DESCRIPTION")
        echo "移除现有的 Linux 兼容层"
        ;;
    "INSTALL_SELECT")
        echo "选择你想安装的发行版："
        ;;
    "CHECK_SUCCESS")
        echo "环境检查通过"
        ;;
    "CHECK_FAILED_LINUX_NOT_STARTED")
        echo "环境检查未通过，Linux 兼容层未加载。"
        ;;
    "CHECK_FAILED_DBUS_NOT_INSTALLED")
        echo "环境检查未通过，dbus 未安装。"
        ;;
    "CHECK_FAILED_DBUS_NOT_STARTED")
        echo "环境检查未通过，dbus 服务未开启。"
        ;;
    # "CHECK_FAILED_NULLFS_NOT_LOADED")
    #     echo "环境检查未通过，nullfs 模块未加载。"
    #     ;;
    "CHECK_FAILED_CANCELED")
        echo "环境检查被终止。"
        ;;
    "RETURN")
        echo "返回上一级"
        ;;
    "CANCEL_INSTALLATION")
        echo "安装已取消。"
        ;;
    "CANCEL_SETUP")
        echo "配置停止。"
        ;;
    "ABORT")
        echo "终止。"
        ;;
    "GOODBYE")
        echo "再见！"
        ;;

    # scripts/arch.sh
    "INSTALLING")
        echo "正在安装："
        ;;
    "CHOOSE_INSTALL_METHORD")
        echo "请选择安装方法："
        ;;
    "METHORD_USTC_PREBUILT")
        echo "从 ustc 下载预构建的压缩包"
        ;;
    "METHORD_PACMAN")
        echo "使用 FreeBSD 的 archlinux-pacman 安装"
        ;;

    # scripts/check.sh
    "ENABLE_LINUX_OR_NOT")
        echo "Linux 兼容层并没有启用。 是否现在启用它？"
        ;;
    "CONTINUE_WITHOUT_LINUX_ENABLED_OR_NOT")
        echo "警告：系统每次重启都必须执行\"service linux start\"来加载 Linux 兼容层。 是否保持不启用 Linux 兼容层？"
        ;;
    "WARN_LINUX_NOT_ENABLED")
        echo "警告：Linux 兼容层未启用。"
        ;;
    "ENABLE_LINUX")
        echo "正在启用 Linux 兼容层"
        ;;
    "START_LINUX_OR_NOT")
        echo "Linux 兼容层看起来并没有被加载。 是否现在加载 Linux 兼容层？"
        ;;
    "ABORT_LINUX_NOT_START")
        echo "终止。Linux 兼容层未加载。"
        ;;
    "START_LINUX")
        echo "加载 Linux 兼容层"
        ;;
    "INSTALL_DBUS_OR_NOT")
        echo "未找到 dbus-daemon。 是否现在安装？"
        ;;
    "ABORT_DBUS_NOT_INSTALLED")
        echo "终止。dbus 没有安装。"
        ;;
    "INSTALL_DBUS")
        echo "正在安装 dbus"
        ;;
    "ENABLE_DBUS_OR_NOT")
        echo "dbus 没有启用。 是否现在启用它？"
        ;;
    "CONTINUE_WITHOUT_DBUS_ENABLED_OR_NOT")
        echo "警告：每次系统重启都必须执行\"service dbus start\"来运行 dbus 服务。 是否保持 dbus 不启用？"
        ;;
    "WARN_DBUS_NOT_ENABLED")
        echo "警告：dbus 未启用"
        ;;
    "ENABLE_DBUS")
        echo "正在启用 dbus 服务"
        ;;
    "START_DBUS_OR_NOT")
        echo "dbus 服务并未运行。 是否现在运行它？"
        ;;
    "ABORT_DBUS_NOT_STARTED")
        echo "终止。dbus 服务未运行。"
        ;;
    "START_DBUS")
        echo "正在启动 dbus 服务"
        ;;
    # "LOAD_NULLFS_OR_NOT")
    #     echo "应该在启动时加载 nullfs， 是否设置 nullfs_load=YES？"
    #     ;;
    # "CONTINUE_WITHOUT_NULLFS_LOADED_OR_NOT")
    #     echo "警告：每次系统重启都必须执行\"kldload -v nullfs\"来加载 nullfs 模块。 是否保持启动时不加载 nullfs？"
    #     ;;
    # "WARN_NULLFS_NOT_LOADED")
    #     echo "警告：nullfs 启动时不加载"
    #     ;;
    # "LOAD_NULLFS")
    #     echo "正在设置启动时加载 nullfs"
    #     ;;
    # "LOAD_NULLFS_MODULE_OR_NOT")
    #     echo "nullfs 模块并未被加载。 是否现在加载它？"
    #     ;;
    # "ABORT_NULLFS_MODULE_NOT_LOADED")
    #     echo "终止。nullfs 模块未被加载。"
    #     ;;
    # "LOAD_NULLFS_MODULE")
    #     echo "正在加载 nullfs 模块"
    #     ;;

    # scripts/debian.sh
    "CHOOSE_DEBIAN_VERSION")
        echo "请选择 Debian 版本："
        ;;
    "METHORD_BOOTSTRAP")
        echo "通过 debootstrap 安装"
        ;;

    # scripts/deepin.sh
    "CHOOSE_DEEPIN_VERSION")
        echo "请选择 Deepin 版本："
        ;;

    # scripts/fedora.sh
    "CHOOSE_FEDORA_TYPE")
        echo "请选择 Fedora 类型："
        ;;
    "MINIMAL_NOT_RECOMMENDED")
        echo "（不推荐，没有 dnf 等包管理器）"
        ;;
    "FEDORA_ARCH_NOT_SUPPORTED")
        echo "Fedora 不支持 i386"
        ;;

    # scripts/gentoo.sh
    "CHOOSE_GENTOO_TYPE")
        echo "请选择 Gentoo 类型："
        ;;

    # scripts/remove.sh
    "ENTER_DIR")
        echo "请输入 Linux 兼容层所在目录： 注意：所有目录都会被理解为绝对目录"
        ;;
    "WARN_ROOT_DIR")
        echo "警告：不可输入根目录"
        ;;
    "WARN_NOT_LINUX")
        echo "警告：此目录看起来不是 Linux 根目录，是否继续？"
        ;;
    "WARN_REMOVE")
        echo "警告：此目录(${DIRECTORY})会被彻底删除，是否继续？"
        ;;
    "DONE")
        echo "已完成。"
        ;;

    # scripts/suse.sh
    "CHOOSE_SUSE_VERSION")
        echo "请选择 openSUSE 版本："
        ;;
    "CHOOSE_INSTALL_TYPE")
        echo "请选择安装种类："
        ;;
    "TYPE_ZYPPER")
        echo "使用 zypper 包管理器的 openSUSE"
        ;;
    "TYPE_DNF")
        echo "使用 dnf 包管理器的 openSUSE"
        ;;

    # scripts/ubuntu.sh
    "CHOOSE_UBUNTU_VERSION")
        echo "请选择 Ubuntu 版本："
        ;;

    # scripts/setup/arch.sh
    "NOTICE_UNINSTALL_KERNEL")
        echo "注意：Arch Linux ARM 包含内核和 initramfs， 这在 Linux 兼容层中无用。"
        echo "你可以稍后卸载或删除内核和 initramfs。"
        ;;
    "ARCH_NOT_SUPPORT")
        echo "Arch Linux 不支持 i386"
        ;;
    "INSTALL_FAILED_FETCH")
        echo "安装失败。fetch 返回了${STATUS}"
        ;;
    "INSTALL_PACMAN_OR_NOT")
        echo "是否安装 archlinux-pacman？"
        ;;
    "INSTALL_PACMAN")
        echo "正在安装 archlinux-pacman"
        ;;
    "ABORT_PACMAN_NOT_INSTALLED")
        echo "终止。archlinux-pacman 未安装。"
        ;;
    "INSTALL_KEYRING_OR_NOT")
        echo "是否安装 archlinux-keyring？"
        ;;
    "INSTALL_KEYRING")
        echo "正在安装 archlinux-keyring"
        ;;
    "ABORT_KEYRING_NOT_INSTALLED")
        echo "终止。archlinux-keyring 未安装。"
        ;;
    "NOTICE_PACMAN_SOURCE")
        echo "请确保已经正确配置 archlinux core 源"
        ;;
    "INSTALL_COMPLETE")
        echo "${DIST_FULLNAME} 安装完成"
        ;;
    "SETTING_UP")
        echo "正在配置 ${DIST_FULLNAME}"
        ;;
    "INIT_KEY")
        echo "正在初始化 pacman 密钥"
        ;;
    "ADD_SOURCE_OR_NOT")
        echo "是否配置全部 ustc 源？"
        ;;
    "SOURCE_NOT_ADDED")
        echo "ustc 源未配置，你可能需要手动配置软件源。"
        ;;
    "ADD_SOURCE")
        echo "正在配置 ustc 源"
        ;;
    "INSTALL_VIM_OR_NOT")
        echo "兼容层没有文本编辑器。是否安装 vim？"
        ;;
    "INSTALL_VIM")
        echo "正在安装 vim"
        ;;
    "NOTICE_NO_EDITOR")
        echo "注意：你可以稍后安装文本编辑器或使用 FreeBSD 中的文本编辑器。"
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
        echo "配置全部完成。 你现在可以执行\"chroot ${INSTALL_DIR} /bin/bash\"来切换到 ${DIST_FULLNAME}"
        ;;

    # scripts/setup/basic.sh
    "USE_ALI_DNS_OR_NOT")
        echo "是否使用阿里 DNS？ 如果否，则默认使用本地 resolv.conf 文件。"
        ;;
    "USE_ALI_DNS")
        echo "正在配置阿里 DNS"
        ;;
    "USE_LOCAL_DNS")
        echo "正在使用本地 DNS 文件："
        ;;
    "ADD_FSTAB")
        echo "正在配置 fstab"
        ;;
    "ADD_FSTAB_OR_NOT")
        echo "是否自动配置 fstab？"
        ;;
    "CONTINUE_WITHOUT_FSTAB_ADDED")
        echo "警告：fstab 未配置，要想正常使用兼容层， 每次系统重启都必须手动挂载相关文件系统。 是否继续？"
        ;;
    "WARN_FSTAB_NOT_ADDED")
        echo "警告：fstab 未配置，兼容层可能无法正常使用。 你可以在 /etc/fstab 中添加以下配置并使用\"mount -al\"进行挂载。"
        ;;

    # scripts/setup/debian.sh
    "INSTALL_FAILED")
        echo "安装失败。debootstrap 返回了${STATUS}"
        ;;
    "REMOVE_DEBOOTSTRAP_FILES")
        echo "正在移除 debootstrap 文件"
        ;;
    "DEBIAN_12_SOURCE_NOT_ADDED")
        echo "镜像源未配置，仅有 bookworm main 可用"
        ;;
    "DEBIAN_11_SOURCE_NOT_ADDED")
        echo "镜像源未配置，仅有 bullseye main 可用"
        ;;

    # scripts/setup/fedora.sh
    "INSTALL_FAILED_TAR")
        echo "安装失败。tar 返回了${STATUS}"
        ;;
    "SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE")
        echo "ustc 源未配置，但官方源可用。"
        ;;

    # scripts/setup/gentoo.sh
    "ADD_FEATURES")
        echo "正在为 Gentoo 添加 make feature"
        ;;
    "COPY_REPO_CONFIG")
        echo "正在复制 repos.conf"
        ;;

    # scripts/setup/kali.sh
    "KALI_SOURCE_NOT_ADDED")
        echo "镜像源未配置，仅有 kali-rolling main 可用"
        ;;

    # scripts/setup/suse.sh
    "OPENSUSE_ARCH_NOT_SUPPORTED")
        echo "openSUSE 不支持 i386"
        ;;
    "REPLACE_RPM_NDB")
        echo "正在将 rpm-ndb 替换为 rpm 以避免错误"
        ;;

    # scripts/setup/ubuntu.sh
    "UBUNTU_ARCH_NOT_SUPPORTED_FETCH")
        echo "Ubuntu i386 不支持以 fetch 的方式安装。 你可以用 debootstrap 安装。"
        ;;
    "ADD_APT_CACHE")
        echo "添加配置“APT::Cache-Start 110663296;”以避免错误"
        ;;
    "USE_HTTPS_SOURCES_OR_NOT")
        echo "是否使用 https 源？这将会安装 ca-certificates"
        ;;
    "USE_HTTPS_SOURCES")
        echo "正在配置 https 源"
        ;;
    "HTTPS_SOURCES_NOT_USED")
        echo "正在使用 http 源"
        ;;
    "UBUNTU_22_SOURCE_NOT_ADDED")
        echo "ustc 源未配置，仅jammy main可用。"
        ;;
    "UBUNTU_20_SOURCE_NOT_ADDED")
        echo "ustc 源未配置，仅focal main可用。"
        ;;

    # scripts/setup/utils.sh
    "CHANGE_INSTALL_DIR_OR_NOT")
        echo "选择安装位置。 注意：所有目录都会被理解为绝对目录"
        ;;
    "NOTICE_INSTALL_DIR")
        echo "${DIST_FULLNAME} 将被安装至 ${INSTALL_DIR}"
        ;;
    "WARN_DIR_IS_FILE")
        echo "警告：${INSTALL_DIR} 是一个文件"
        ;;
    "CONFIRM_INSTALL_DIR_OR_NOT")
        echo "是否确认安装到此位置？"
        ;;
    "WARN_DIR_NOT_EMPTY")
        echo "此路径非空，是否强制安装到此？ （可能破坏原有文件！）"
        ;;
    "INSTALL_DEBOOTSTRAP_OR_NOT")
        echo "debootstrap 未安装。 是否现在安装？"
        ;;
    "INSTALL_DEBOOTSTRAP")
        echo "正在安装 debootstrap"
        ;;
    "INSTALL_FAILED_DEBOOTSTRAP_NOT_INSTALLED")
        echo "安装失败。debootstrap 未安装。"
        ;;

    # fallback
    *)
        echo "$1"
        ;;
    esac
}
