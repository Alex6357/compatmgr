#!/bin/sh

tr () {
    case ${1} in
    "NOTICE_UNINSTALL_KERNEL")
        echo "Notice: Arch Linux ARM include kernel and initramfs, which are useless in Linuxulator."
        echo "You may uninstall them later."
        ;;
    "ARCH_NOT_SUPPORT")
        echo "Arch Linux does not support i386"
        ;;
    "CHANGE_INSTALL_DIR_OR_NOT")
        echo "Select install location"
        ;;
    "CONFIRM_INSTALL_DIR_OR_NOT")
        echo "Install to this directory?"
        ;;
    "WARN_DIR_NOT_EMPTY")
        echo "The directory is not empty. Force install to this directory? (May destroy original files!)"
        ;;
    "NOTICE_INSTALL_DIR")
        echo "${DIST_FULLNAME} will be installed in ${INSTALL_DIR}"
        ;;
    "INSTALL_COMPLETE")
        echo "${DIST_FULLNAME} installation complete"
        ;;
    "INSTALL_FAILED_FETCH")
        echo "Installation failed. fetch has returned ${STATUS}"
        ;;
    "INSTALL_FAILED_TAR")
        echo "Installation failed. tar has returned ${STATUS}"
        ;;
    "SETTING_UP")
        echo "Setting ${DIST_FULLNAME}"
        ;;
    *)
        echo ${1}
        ;;
    esac
}
