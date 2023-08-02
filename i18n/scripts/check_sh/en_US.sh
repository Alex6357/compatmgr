#!/bin/sh

tr () {
    case $1 in
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
        *)
            echo "$1"
            ;;
    esac
} 
