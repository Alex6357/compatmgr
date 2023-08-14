#!/bin/sh

tr () {
    case ${1} in
    "ADD_FEATURES")
        echo "Adding make features to Gentoo"
        ;;
    "COPY_REPO_CONFIG")
        echo "Copying repo config file"
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