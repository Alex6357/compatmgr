#!/bin/sh

tr () {
    case ${1} in
    "USE_ALI_DNS_OR_NOT")
        echo "Do you want to use Ali DNS? If not, local resolv.conf will be used by default."
        ;;
    "USE_LOCAL_DNS")
        echo "Using local resolv.conf:"
        ;;
    "USE_ALI_DNS")
        echo "Setting Ali DNS"
        ;;
    "ADD_FSTAB_OR_NOT")
        echo "Autoset fstab?"
        ;;
    "WARN_MOUNT_MANUALLY")
        echo "Warning: fstab not set. You MUST mount relative filesystems EACH TIME FREEBSD IS REBOOTED."
        ;;
    "CONTINUE_WITHOUT_FSTAB_ADDED")
        echo "Continue without setting fstab?"
        ;;
    "WARN_FSTAB_NOT_ADDED")
        echo "Warning: fstab not set. You can add the followings to /etc/fstab and mount with \"mount -al\""
        ;;
    "ADD_FSTAB")
        echo "Setting fstab"
        ;;
    "ADD_APT_CACHE")
        echo "Adding APT::Cache-Start 110663296; to avoid error"
        ;;
    "ADD_SOURCE_OR_NOT")
        echo "Use ALL ustc sources?"
        ;;
    "SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE")
        echo "ustc sources not set, but official sources are avaliable."
        ;;
    "SOURCE_NOT_ADDED_MAIN_ONLY")
        echo "ustc sources not set. Only jammy main avaliable."
        ;;
    "ADD_SOURCE")
        echo "Setting ustc sources"
        ;;
    "USE_HTTPS_SOURCES_OR_NOT")
        echo "Use https sources? Notice this will also install ca-certificates"
        ;;
    "USE_HTTPS_SOURCES")
        echo "Setting https sources"
        ;;
    "HTTPS_SOURCES_NOT_USED")
        echo "Using http sources"
        ;;
    "INSTALL_VIM_OR_NOT")
        echo "This package doesn't contain any editor. Install vim as your aditor?"
        ;;
    "INSTALL_VIM")
        echo "Installing vim"
        ;;
    "NOTICE_NO_EDITOR")
        echo "Notice: you may install an editor later or use editors in FreeBSD."
        ;;
    "SETUP_COMPLETE")
        echo "All done."
        ;;
    "NOTICE_COMMAMD")
        echo "Now you can switch to ${DIST_FULLNAME} using \"chroot ${INSTALL_DIR} /bin/bash\""
        ;;
    *)
        echo ${1}
        ;;
    esac
}
