#!/bin/sh

tr () {
    case ${1} in
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
    *)
        echo ${1}
        ;;
    esac
}