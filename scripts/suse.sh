#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

while true; do
    CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
             --ok-label "$(trans OK)" \
             --menu "$(trans CHOOSE_SUSE_VERSION)" \
             0 0 2 \
             "Leap 15.5" "openSUSE Leap 15.5" \
             "Tumbleweed" "openSUSE Tumbleweed" \
             3>&2 2>&1 1>&3)

    STATUS=${?}
    case ${STATUS} in
    1)
        exit 5
        ;;
    0)
        ;;
    *)
        exit 2
        ;;
    esac

    case ${CHOICE} in
    "Leap 15.5")
        while true; do
            CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
                     --ok-label "$(trans OK)" \
                     --hline "$(trans INSTALLING)openSUSE Leap 15.5" \
                     --menu "$(trans CHOOSE_INSTALL_TYPE)" \
                     0 0 2 \
                     "zypper" "$(trans TYPE_ZYPPER)" \
                     "dnf" "$(trans TYPE_DNF)" \
                     3>&2 2>&1 1>&3)
            STATUS=${?}
            case ${STATUS} in
            1)
                break
                ;;
            0)
                ;;
            *)
                exit 2
                ;;
            esac

            case ${CHOICE} in
            "zypper")
                export TYPE="Leap"
                export VERSION="15.5"
                export PKG="zypper"
                ${DIR}/scripts/setup/suse.sh
                STATUS=${?}
                case ${STATUS} in 
                0)
                    exit 0
                    ;;
                1)
                    exit 2
                    ;;
                2)
                    exit 3
                    ;;
                esac
                ;;
            "dnf")
                export TYPE="Leap"
                export VERSION="15.5"
                export PKG="dnf"
                ${DIR}/scripts/setup/suse.sh
                STATUS=${?}
                case ${STATUS} in 
                0)
                    exit 0
                    ;;
                1)
                    exit 2
                    ;;
                2)
                    exit 3
                    ;;
                esac
                ;;
            *)
                exit 2
                ;;
            esac
        done
        ;;
    "Tumbleweed")
        while true; do
            CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
                     --ok-label "$(trans OK)" \
                     --hline "$(trans INSTALLING)openSUSE Tunbleweed" \
                     --menu "$(trans CHOOSE_INSTALL_TYPE)" \
                     0 0 2 \
                     "zypper" "$(trans TYPE_ZYPPER)" \
                     "dnf" "$(trans TYPE_DNF)" \
                     3>&2 2>&1 1>&3)
            STATUS=${?}
            case ${STATUS} in
            1)
                break
                ;;
            0)
                ;;
            *)
                exit 2
                ;;
            esac

            case ${CHOICE} in
            "zypper")
                export TYPE="Tumbleweed"
                export PKG="zypper"
                ${DIR}/scripts/setup/suse.sh
                case ${STATUS} in 
                0)
                    exit 0
                    ;;
                1)
                    exit 2
                    ;;
                2)
                    exit 3
                    ;;
                esac
                ;;
            "dnf")
                export TYPE="Tumbleweed"
                export PKG="dnf"
                ${DIR}/scripts/setup/suse.sh
                STATUS=${?}
                case ${STATUS} in 
                0)
                    exit 0
                    ;;
                1)
                    exit 2
                    ;;
                2)
                    exit 3
                    ;;
                esac
                ;;
            *)
                exit 2
                ;;
            esac
        done
        ;;
    *)
        exit 2
        ;;
    esac
done
