#!/bin/sh

tr () {
    case $1 in
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
    *)
        echo "$1"
        ;;
    esac
}
