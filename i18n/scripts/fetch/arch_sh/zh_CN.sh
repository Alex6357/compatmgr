#!/bin/sh

tr () {
    case ${1} in
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
    *)
        echo ${1}
        ;;
    esac
}
