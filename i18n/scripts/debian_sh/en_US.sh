#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_DEBIAN_VERSION")
        echo "Choose Debian version: "
        ;;
    "INSTALLING")
        echo "Installing: "
        ;;
    "CHOOSE_INSTALL_METHORD")
        echo "Please select installation METHORD: "
        ;;
    "METHORD_BOOTSTRAP")
        echo "Install by debootstrap"
        ;;
    "METHORD_PREBUILT")
        echo "Download prebuilt package(not an official release)"
        ;;
    "RETURN")
        echo "Return to previous menu"
        ;;
    "REQUIRE_CHOICE")
        echo "Enter your choice: "
        ;;
    *)
        echo ${1}
        ;;
    esac
}
