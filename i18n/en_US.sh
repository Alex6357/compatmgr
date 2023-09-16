#!/bin/sh

tr () {
    case $1 in
    # compatmgr.sh
    "ARCH_NOT_SUPPORTED")
        echo "ERROR: Your architecture $(sysctl -n hw.machine_arch) is not supported."
        ;;
    "NOT_RUN_BY_ROOT")
        echo "ERROR: compatmgr must be run as root"
        ;;
    "WELCOME")
        echo "Welcome to use FreeBSD compat manager! Author: Alex11"
        ;;
    "PLEASE_SELECT")
        echo "Please choose: "
        ;;
    "CHOICE_CHECK")
        echo "Check environment"
        ;;
    "CHOICE_INSTALL")
        echo "Install compat layers"
        ;;
    "CHOICE_REMOVE")
        echo "Remove compat layers"
        ;;
    "CHOICE_EXIT")
        echo "Exit"
        ;;
    "REQUIRE_CHOICE")
        echo "Enter your choice: "
        ;;
    "GOODBYE")
        echo "Goodbye!"
        ;;
    "INSTALL_SELECT")
        echo "Select the distribution you want to install: "
        ;;
    "CHOICE_RETURN")
        echo "Return to previous menu"
        ;;
    "REMOVE_SELECT")
        echo "Select the distribution you want to remove: "
        ;;
    "CHECK_SUCCESS")
        echo "Environment check succeed."
        ;;
    "CHECK_FAILED_LINUX_NOT_STARTED")
        echo "Environment check failed because linux service was not started."
        ;;
    "CHECK_FAILED_DBUS_NOT_INSTALLED")
        echo "Environment check failed because DBus was not installed."
        ;;
    "CHECK_FAILED_DBUS_NOT_STARTED")
        echo "Environment check failed because DBus service was not started."
        ;;
    "CHECK_FAILED_NULLFS_NOT_LOADED")
        echo "Environment check failed because nullfs module was not loaded."
        ;;

    # scripts/check.sh
    "CHECK_START")
        echo "Checking relative modules"
        ;;
    "ENABLE_LINUX_OR_NOT")
        echo "Linux service is not enabled. Enable it now?"
        ;;
    "WARN_START_LINUX")
        echo "Warning: You MUST start linux service with \"service linux start\" EACH TIME FREEBSD IS REBOOTED."
        ;;
    "CONTINUE_WITHOUT_LINUX_ENABLED_OR_NOT")
        echo "Sure to continue without enabling linux service?"
        ;;
    "WARN_LINUX_NOT_ENABLED")
        echo "WARNING: linux moudle not enabled"
        ;;
    "ENABLE_LINUX")
        echo "Enabling linux moudle"
        ;;
    "START_LINUX_OR_NOT")
        echo "Linux service seems not Started. Start it now?"
        ;;
    "ABORT_LINUX_NOT_START")
        echo "Aborting. Linux service not started."
        ;;
    "START_LINUX")
        echo "Starting linux service"
        ;;
    "INSTALL_DBUS_OR_NOT")
        echo "dbus-daemon not found. Install dbus now?"
        ;;
    "ABORT_DBUS_NOT_INSTALLED")
        echo "Abort. dbus not installed"
        ;;
    "INSTALL_DBUS")
        echo "Installing dbus"
        ;;
    "ENABLE_DBUS_OR_NOT")
        echo "dbus is not enabled. Enable it now?"
        ;;
    "WARN_START_DBUS")
        echo "WARNING: You MUST start dbus with \"service dbus start\" EACH TIME FREEBSD IS REBOOTED."
        ;;
    "CONTINUE_WITHOUT_DBUS_ENABLED_OR_NOT")
        echo "Sure to continue without enabling dbus?"
        ;;
    "WARN_DBUS_NOT_ENABLED")
        echo "Warning: dbus not enabled"
        ;;
    "ENABLE_DBUS")
        echo "Enabling dbus service"
        ;;
    "START_DBUS_OR_NOT")
        echo "dbus seems not started. Start it now?"
        ;;
    "ABORT_DBUS_NOT_STARTED")
        echo "Abort. dbus not started."
        ;;
    "START_DBUS")
        echo "Starting dbus service"
        ;;
    "LOAD_NULLFS_OR_NOT")
        echo "nullfs should be loaded when boot. Set nullfs_load to YES?"
        ;;
    "WARN_LOAD_NULLFS")
        echo "Warning: You MUST load nullfs with \"kldload -v nullfs\" EACH TIME FREEBSD IS REBOOTED."
        ;;
    "CONTINUE_WITHOUT_NULLFS_LOADED_OR_NOT")
        echo "Sure to continue without setting nullfs_load to YES?"
        ;;
    "WARN_NULLFS_NOT_LOADED")
        echo "Warning: nullfs_load not set"
        ;;
    "LOAD_NULLFS")
        echo "Setting nullfs_load to YES"
        ;;
    "LOAD_NULLFS_MODULE_OR_NOT")
        echo "nullfs module seems not loaded. Load it now?"
        ;;
    "ABORT_NULLFS_MODULE_NOT_LOADED")
        echo "Aborting. nullfs module not loaded."
        ;;
    "LOAD_NULLFS_MODULE")
        echo "Loading nullfs module"
        ;;

    # scripts/debian.sh
    "CHOOSE_DEBIAN_VERSION")
        echo "Choose Debian version: "
        ;;
    "INSTALLING")
        echo "Installing: "
        ;;
    "CHOOSE_INSTALL_METHORD")
        echo "Please select installation methord: "
        ;;
    "METHORD_BOOTSTRAP")
        echo "Install by debootstrap"
        ;;
    "METHORD_PREBUILT")
        echo "Download prebuilt package(not an official release!)"
        ;;
    "RETURN")
        echo "Return to previous menu"
        ;;

    # scripts/deepin.sh
    "CHOOSE_DEEPIN_VERSION")
        echo "Choose Debian version: "
        ;;

    # scripts/fedora.sh
    "CHOOSE_FEDORA_TYPE")
        echo "Choose Fedora type: "
        ;;
    "MINIMAL_NOT_RECOMMENDED")
        echo "(Not recommend. Does not have dnf.)"
        ;;

    # scripts/gentoo.sh
    "CHOOSE_GENTOO_TYPE")
        echo "Choose Gentoo type: "
        ;;

    # scripts/suse.sh
    "CHOOSE_SUSE_VERSION")
        echo "Choose openSUSE version: "
        ;;
    "CHOOSE_INSTALL_TYPE")
        echo "Please select installation type: "
        ;;
    "TYPE_ZYPPER")
        echo "openSUSE with zypper"
        ;;
    "TYPE_DNF")
        echo "openSUSE with dnf"
        ;;

    # scripts/ubuntu.sh
    "CHOOSE_UBUNTU_VERSION")
        echo "Choose Ubuntu version: "
        ;;
    "METHORD_UBUNTU_PREBUILT")
        echo "Download prebuilt package from ustc"
        ;;

    # scripts/remove.sh
    "ENTER_DIR")
        echo "Please enter directory: "
        ;;
    "WARN_NOT_LINUX")
        echo "Warning: This directory does not appear to be a Linux root directory, continue? "
        ;;
    "WARN_REMOVE")
        echo "Warning: This directory will be removed permanently, continue? "
        ;;
    "ABORT")
        echo "Aborting."
        ;;
    "DONE")
        echo "Done."
        ;;

    # scripts/fetch/arch.sh
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

    # scripts/fetch/debian/bootstrap.sh
    "INSTALL_DEBOOTSTRAP_OR_NOT")
        echo "debootstrap not installed. Install it now?"
        ;;
    "INSTALL_FAILED_DEBOOTSTRAP_NOT_INSTALLED")
        echo "Installation failed. debootstrap not installed."
        ;;
    "INSTALL_DEBOOTSTRAP")
        echo "Installing debootstrap"
        ;;
    "INSTALL_FAILED")
        echo "Installation failed. debootstrap has returned ${STATUS}"
        ;;

    # scripts/fetch/deepin/bootstrap.sh
    "DEEPIN_ARCH_NOT_SUPPORTED")
        echo "Deepin does not support ARM64"
        ;;

    # scripts/fetch/fedora.sh
    "FEDORA_ARCH_NOT_SUPPORTED")
        echo "Fedora does not support i386"
        ;;

    # scripts/fetch/kali/bootstrap.sh
    "REMOVE_DEBOOTSTRAP_FILES")
        echo "Removing debootstrap files"
        ;;

    # scripts/fetch/suse.sh
    "OPENSUSE_ARCH_NOT_SUPPORTED")
        echo "openSUSE does not support i386"
        ;;

    # scripts/fetch/ubuntu/bootstrap.sh
    "UBUNTU_ARCH_NOT_SUPPORTED_FETCH")
        echo "Ubuntu i386 does not support fetch install. You can install it with debootstrap."
        ;;

    # scripts/setup/basic.sh
    "USE_ALI_DNS_OR_NOT")
        echo "Do you want to use Ali DNS? If not, local resolv.conf will be used by default."
        ;;
    "USE_LOCAL_DNS")
        echo "Using local resolv.conf: "
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

    # scripts/setup/arch.sh
    "INIT_KEY")
        echo "Initializing pacman keyring"
        ;;
    "ADD_SOURCE_OR_NOT")
        echo "Use ALL ustc sources?"
        ;;
    "SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE")
        echo "ustc sources not set, but official sources are avaliable."
        ;;
    "ADD_SOURCE")
        echo "Setting ustc sources"
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
    "ADD_ARCHCN_OR_NOT")
        echo "Add Arch Linux CN source?"
        ;;
    "ARCHCN_NOT_ADDED")
        echo "Arch Linux CN source not added."
        ;;
    "ADD_ARCHCN")
        echo "Adding Arch Linux CN source"
        ;;
    "SETUP_COMPLETE")
        echo "All done."
        ;;
    "NOTICE_COMMAMD")
        echo "Now you can switch to ${DIST_FULLNAME} using \"chroot ${INSTALL_DIR} /bin/bash\""
        ;;

    # scripts/setup/debian.sh
    "SOURCE_NOT_ADDED")
        echo "ustc sources not set. Only bookworm main avaliable"
        ;;
    "SOURCE_NOT_ADDED")
        echo "ustc sources not set. Only bullseye main avaliable"
        ;;

    # scripts/setup/fedora.sh
    "SOURCE_NOT_ADDED_OFFICIAL_AVALIABLE")
        echo "ustc sources not set, but official sources are avaliable."
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

    # scripts/setup/gentoo.sh
    "ADD_FEATURES")
        echo "Adding make features to Gentoo"
        ;;
    "COPY_REPO_CONFIG")
        echo "Copying repo config file"
        ;;

    # scripts/setup/kali.sh
    "KALI_SOURCE_NOT_ADDED")
        echo "ustc sources not set. Only kali-rolling main avaliable"
        ;;

    # scripts/setup/suse.sh
    "REPLACE_RPM_NDB")
        echo "Replacing rpm-ndb with rpm to avoid errors."
        ;;

    # scripts/setup/ubuntu.sh
    "ADD_APT_CACHE")
        echo "Adding APT::Cache-Start 110663296; to avoid error"
        ;;
    "UBUNTU_22_SOURCE_NOT_ADDED")
        echo "ustc sources not set. Only jammy main avaliable."
        ;;
    "UBUNTU_20_SOURCE_NOT_ADDED")
        echo "ustc sources not set. Only focal main avaliable."
        ;;

    *)
        echo "$1"
        ;;
    esac
}
