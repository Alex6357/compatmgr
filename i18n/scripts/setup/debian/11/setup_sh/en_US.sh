#!/bin/sh

tr () {
    case ${1} in
    "ADD_SOURCE_OR_NOT")
        echo "Use ALL ustc sources?"
        ;;
    "SOURCE_NOT_ADDED")
        echo "ustc sources not set. Only bullseye main avaliable"
        ;;
    "ADD_SOURCE")
        echo "Setting ustc sources"
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
