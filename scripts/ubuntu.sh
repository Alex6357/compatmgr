#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

while true; do
    CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
             --ok-label "$(trans OK)" \
             --menu "$(trans CHOOSE_UBUNTU_VERSION)" \
             0 0 2 \
             "Ubuntu 22.04" "Ubuntu jammy" \
             "Ubuntu 20.04" "Debian focal" \
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
    "Ubuntu 22.04")
        while true; do
            CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
                     --ok-label "$(trans OK)" \
                     --hline "$(trans INSTALLING)Ubuntu 22.04 (jammy)" \
                     --menu "$(trans CHOOSE_INSTALL_METHORD)" \
                     0 0 2 \
                     "debootstrap" "$(trans METHORD_BOOTSTRAP)" \
                     "prebuilt" "$(trans METHORD_USTC_PREBUILT)" \
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
            "debootstrap")
                export METHORD="debootstrap"
                export VERSION="22.04"
                ${DIR}/scripts/setup/ubuntu.sh
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
            "prebuilt")
                export METHORD="prebuilt"
                export VERSION="22.04"
                ${DIR}/scripts/setup/ubuntu.sh
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
    "Ubuntu 20.04")
        while true; do
            CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
                     --ok-label "$(trans OK)" \
                     --hline "$(trans INSTALLING)Ubuntu 20.04 (focal)" \
                     --menu "$(trans CHOOSE_INSTALL_METHORD)" \
                     0 0 2 \
                     "debootstrap" "$(trans METHORD_BOOTSTRAP)" \
                     "prebuilt" "$(trans METHORD_USTC_PREBUILT)" \
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
            "debootstrap")
                export METHORD="debootstrap"
                export VERSION="20.04"
                ${DIR}/scripts/setup/ubuntu.sh
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
            "prebuilt")
                export METHORD="prebuilt"
                export VERSION="20.04"
                ${DIR}/scripts/setup/ubuntu.sh
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
