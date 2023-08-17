#!/bin/sh

tr () {
    case ${1} in
    "ARCH_NOT_SUPPORTED")
        echo "Deepin does not support ARM64"
        ;;
    "INSTALL_DEBOOTSTRAP_OR_NOT")
        echo "debootstrap not installed. Install it now?"
        ;;
    "INSTALL_FAILED_DEBOOTSTRAP_NOT_INSTALLED")
        echo "Installation failed. debootstrap not installed."
        ;;
    "INSTALL_DEBOOTSTRAP")
        echo "Installing debootstrap"
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
    "INSTALL_FAILED")
        echo "Installation failed. debootstrap has returned ${STATUS}"
        ;;
    "SETTING_UP")
        echo "Setting ${DIST_FULLNAME}"
        ;;
    *)
        echo ${1}
        ;;
    esac
}
