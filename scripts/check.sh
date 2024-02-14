#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi


if ! $(sysrc -qn linux_enable | grep -qe '[Yy][Ee][Ss]'); then
    bsddialog --yesno "$(trans ENABLE_LINUX_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    1)
        bsddialog --default-no --yesno "$(trans CONTINUE_WITHOUT_LINUX_ENABLED_OR_NOT)" 0 0
        ANSWER=${?}
        case ${ANSWER} in
        0)
            bsddialog --msgbox "$(trans WARN_LINUX_NOT_ENABLED)" 0 0
            ;;
        1)
            echo "$(trans ENABLE_LINUX)"
            sysrc linux_enable=YES
            ;;
        *)
            exit 5
            ;;
        esac
        ;;
    0)
        echo "$(trans ENABLE_LINUX)"
        sysrc linux_enable=YES
        ;;
    *)
        exit 5
        ;;
    esac
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
    bsddialog --yesno "$(trans START_LINUX_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    1)
        bsddialog --msgbox "$(trans ABORT_LINUX_NOT_START)" 0 0
        exit 1
        ;;
    0)
        echo "$(trans START_LINUX)"
        service linux onestart
        ;;
    *)
        exit 5
        ;;
    esac
fi


if ! command -v dbus-daemon > /dev/null 2>&1; then
    bsddialog --yesno "$(trans INSTALL_DBUS_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    1)
        bsddialog --msgbox "$(trans ABORT_DBUS_NOT_INSTALLED)" 0 0
        exit 2
        ;;
    0)
        echo $(trans INSTALL_DBUS)
        pkg install -y dbus
        ;;
    *)
        exit 5
        ;;
    esac
fi


if ! sysrc -qn dbus_enable | grep -qe '[Yy][Ee][Ss]'; then
    bsddialog --yesno "$(trans ENABLE_DBUS_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    1)
        bsddialog --default-no --yesno "$(trans CONTINUE_WITHOUT_DBUS_ENABLED_OR_NOT)" 0 0
        ANSWER=${?}
        case ${ANSWER} in
        0)
            bsddialog --msgbox "$(trans WARN_DBUS_NOT_ENABLED)" 0 0
            ;;
        1)
            echo $(trans ENABLE_DBUS)
            sysrc dbus_enable="YES"
            ;;
        *)
            exit 5
            ;;
        esac
        ;;
    0)
        echo $(trans ENABLE_DBUS)
        sysrc dbus_enable="YES"
        ;;
    *)
        exit 5
        ;;
    esac
fi

if [ -z "`ps aux | grep -p dbus | grep -v grep`" ]; then
    bsddialog --yesno "$(trans START_DBUS_OR_NOT)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    1)
        bsddialog --msgbox "$(trans ABORT_DBUS_NOT_START)" 0 0
        exit 3
        ;;
    0)
        echo $(trans START_DBUS)
        service dbus start
        ;;
    *)
        exit 5
        ;;
    esac
fi

# if [ ! $(sysrc -f /boot/loader.conf -qn nullfs_load | grep [Yy][Ee][Ss]) ]; then
#     bsddialog --yesno "$(trans LOAD_NULLFS_OR_NOT)" 0 0
#     ANSWER=${?}
#     case ${ANSWER} in
#     1)
#         bsddialog --default-no --yesno "$(trans CONTINUE_WITHOUT_NULLFS_LOADED_OR_NOT)" 0 0
#         ANSWER=${?}
#         case ${ANSWER} in
#         0)
#             bsddialog --msgbox "$(trans WARN_NULLFS_NOT_LOADED)" 0 0
#             ;;
#         1)
#             echo $(trans LOAD_NULLFS)
#             sysrc -f /boot/loader.conf nullfs_load="YES"
#             ;;
#         *)
#             exit 5
#             ;;
#         esac
#         ;;
#     0)
#         echo $(trans LOAD_NULLFS)
#         sysrc -f /boot/loader.conf nullfs_load="YES"
#         ;;
#     *)
#         exit 5
#         ;;
#     esac
# fi


# if [ -z "`kldstat -n nullfs`" ]; then
#     bsddialog --yesno "$(trans LOAD_NULLFS_MODULE_OR_NOT)" 0 0
#     ANSWER=${?}
#     case ${ANSWER} in
#     1)
#         bsddialog --msgbox "$(trans ABORT_NULLFS_MODULE_NOT_LOADED)" 0 0
#         exit 4
#         ;;
#     0)
#         echo $(trans LOAD_NULLFS_MODULE)
#         kldload -v nullfs
#         ;;
#     *)
#         exit 5
#         ;;
#     esac
# fi

exit 0
