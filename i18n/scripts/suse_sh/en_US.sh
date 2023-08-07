#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_SUSE_VERSION")
        echo "Choose openSUSE version: "
        ;;
    "INSTALLING")
        echo "Installing: "
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
