#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

echo $(trans CHECK_START)

if [ ! "`sysrc -n linux_enable`" = "YES" ]; then
    while true; do
        echo -n "$(trans ENABLE_LINUX_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans WARN_START_LINUX)
            while true; do
                echo -n "$(trans CONTINUE_WITHOUT_LINUX_ENABLED_OR_NOT)[y|N]: "
                read ANSWER
                case ${ANSWER} in
                [Yy][Ee][Ss]|[Yy])
                    echo $(trans WARN_LINUX_NOT_ENABLED)
                    break
                    ;;
                [Nn][Oo]|[Nn]|"")
                    echo $(trans ENABLE_LINUX)
                    sysrc linux_enable=YES
                    break
                    ;;
                *)
                    ;;
                esac
            done
            break
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans ENABLE_LINUX)
            sysrc linux_enable=YES
            break
            ;;
        *)
            ;;
        esac
    done
fi

LINUX_ENABLED=1

case "`sysctl -n hw.machine_arch`" in
aarch64)
    if [ -z "`kldstat | grep linux64`" ]; then
        LINUX_ENABLED=0
    fi
    ;;
amd64)
    if [ -z "`kldstat | grep linux | grep linux64`" ]; then
        LINUX_ENABLED=0
    fi
    ;;
i386)
    if [ -z "`kldstat | grep linux`" ]; then
        LINUX_ENABLED=0
    fi
    ;;
esac

if [ -z "`kldstat | grep -E "pty|fdescfs|linprocfs|linsysfs"`" ]; then
    LINUX_ENABLED=0
fi

if [ ${LINUX_ENABLED} = 0 ]; then
    while true; do
        echo -n "$(trans START_LINUX_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans ABORT_LINUX_NOT_START)
            exit 1
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans START_LINUX)
            service linux onestart
            break
            ;;
        *)
            ;;
        esac
    done
fi


if ! which -s dbus-daemon; then
    while true; do
        echo -n "$(trans INSTALL_DBUS_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans ABORT_DBUS_NOT_INSTALLED)
            exit 2
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans INSTALL_DBUS)
            pkg install -y dbus
            break
            ;;
        *)
            ;;
        esac
    done
fi


if [ ! $(sysrc -n dbus_enable | grep [Yy][Ee][Ss]) ]; then
    while true; do
        echo -n "$(trans ENABLE_DBUS_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans WARN_START_DBUS)
            while true; do
                echo -n "$(trans CONTINUE_WITHOUT_DBUS_ENABLED_OR_NOT)[y|N]: "
                read ANSWER
                case ${ANSWER} in
                [Yy][Ee][Ss]|[Yy])
                    echo $(trans WARN_DBUS_NOT_ENABLED)
                    break
                    ;;
                [Nn][Oo]|[Nn]|"")
                    echo $(trans ENABLE_DBUS)
                    sysrc dbus_enable="YES"
                    break
                    ;;
                *)
                    ;;
                esac
            done
            break
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans ENABLE_DBUS)
            sysrc dbus_enable="YES"
            break
            ;;
        *)
            ;;
        esac
    done
fi

if [ -z "`ps aux | grep -p dbus | grep -v grep`" ]; then
    while true; do
        echo -n "$(trans START_DBUS_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans ABORT_DBUS_NOT_START)
            exit 3
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans START_DBUS)
            service dbus start
            break
            ;;
        *)
            ;;
        esac
    done
fi

if [ ! "`sysrc -f /boot/loader.conf -qn nullfs_load`" = "YES" ]; then
    while true; do
        echo -n "$(trans LOAD_NULLFS_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans WARN_LOAD_NULLFS)
            while true; do
                echo -n "$(trans CONTINUE_WITHOUT_NULLFS_LOADED_OR_NOT)[y|N]: "
                read ANSWER
                case ${ANSWER} in
                [Yy][Ee][Ss]|[Yy])
                    echo $(trans WARN_NULLFS_NOT_LOADED)
                    break
                    ;;
                [Nn][Oo]|[Nn]|"")
                    echo $(trans LOAD_NULLFS)
                    sysrc -f /boot/loader.conf nullfs_load="YES"
                    break
                    ;;
                *)
                    ;;
                esac
            done
            break
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans LOAD_NULLFS)
            sysrc -f /boot/loader.conf nullfs_load="YES"
            break
            ;;
        *)
            ;;
        esac
    done
fi


if [ -z "`kldstat -n nullfs`" ]; then
    while true; do
        echo -n "$(trans LOAD_NULLFS_MODULE_OR_NOT)[Y|n]: "
        read ANSWER
        case ${ANSWER} in
        [Nn][Oo]|[Nn])
            echo $(trans ABORT_NULLFS_MODULE_NOT_LOADED)
            exit 4
            ;;
        [Yy][Ee][Ss]|[Yy]|"")
            echo $(trans LOAD_NULLFS_MODULE)
            kldload -v nullfs
            break
            ;;
        *)
            ;;
        esac
    done
fi

exit 0
