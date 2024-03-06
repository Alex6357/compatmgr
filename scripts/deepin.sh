#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi

while true; do

    CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
             --ok-label "$(trans OK)" \
             --menu "$(trans CHOOSE_DEEPIN_VERSION)" \
             0 0 1 \
             "Deepin 23" "Deepin beige (beta)" \
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
    "Deepin 23")
        while true; do

            CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
                     --ok-label "$(trans OK)" \
                     --hline "$(trans INSTALLING)Deepin 23 (beige) (beta)" \
                     --menu "$(trans CHOOSE_INSTALL_METHORD)" \
                     0 0 1 \
                     "debootstrap" "$(trans METHORD_BOOTSTRAP)" \
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
                ${DIR}/scripts/fetch/deepin/23/bootstrap.sh
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
            # 2)
            #     ${DIR}/scripts/fetch/debian/12/fetch.sh
            #     break
            #     ;;
            *)
                exit 2
                ;;
            esac
        done
        ;;
    "Deepin 20")
        while true; do

            CHOICE=$(bsddialog --cancel-label "$(trans RETURN)" \
                     --ok-label "$(trans OK)" \
                     --hline "$(trans INSTALLING)Deepin 20 (apricot)" \
                     --menu "$(trans CHOOSE_INSTALL_METHORD)" \
                     0 0 1 \
                     "debootstrap" "$(trans METHORD_BOOTSTRAP)" \
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
                ${DIR}/scripts/fetch/deepin/20/bootstrap.sh
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
            # 2)
            #     ${DIR}/scripts/fetch/debian/11/fetch.sh
            #     break
            #     ;;
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
