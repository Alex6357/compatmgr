#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_DEBIAN_VERSION")
        echo "Choose Ubuntu version:"
        ;;
    "INSTALLING")
        echo "Installing: "
        ;;
    "CHOOSE_INSTALL_METHORD")
        echo "Please select installation methord:"
        ;;
    "METHORD_BOOTSTRAP")
        echo "Install by debootstrap"
        ;;
    "METHORD_PREBUILT")
        echo "Download prebuilt package from ustc"
        ;;
    "RETURN")
        echo "Return to previous menu"
        ;;
    "REQUIRE_CHOICE")
        echo "Enter your choice:"
        ;;
    *)
        echo ${1}
        ;;
    esac
}
