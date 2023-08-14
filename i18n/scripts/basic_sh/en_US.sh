#!/bin/sh

tr () {
    case ${1} in
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
    *)
        echo ${1}
        ;;
    esac
}