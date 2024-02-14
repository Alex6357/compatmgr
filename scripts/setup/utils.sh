#!/bin/sh

get_install_dir(){
    while true; do
        INSTALL_DIR=$(bsddialog --cancel-label "$(trans CANCEL_INSTALLATION)" \
                        --ok-label "$(trans OK)" \
                        --inputbox "$(trans CHANGE_INSTALL_DIR_OR_NOT)" \
                        0 40 \
                        "${DEFAULT_INSTALL_DIR}" \
                        3>&2 2>&1 1>&3)
        STATUS=${?}
        case ${STATUS} in
        0)
            ;;
        *)
            INSTALL_DIR=""
            break
            ;;
        esac

        case ${INSTALL_DIR} in
        ""|"/")
            bsddialog --msgbox "$(trans WARN_ROOT_DIR)" 0 0 3>&2 2>&1 1>&3
            continue
            ;;
        *)
            ;;
        esac

        if [ -f ${INSTALL_DIR} ]; then
            export INSTALL_DIR
            bsddialog --msgbox "$(trans WARN_DIR_IS_FILE)" 0 0 3>&2 2>&1 1>&3
            continue
        fi

        bsddialog --cancel-label "$(trans RETURN)" \
        --ok-label "$(trans OK)" \
        --yesno "$(trans CONFIRM_INSTALL_DIR_OR_NOT)(${INSTALL_DIR})" \
        0 0 \
        3>&2 2>&1 1>&3
        ANSWER=${?}
        case ${ANSWER} in
        0)
            ;;
        *)
            continue
            ;;
        esac

        if [ -d ${INSTALL_DIR} ] && [ "$(ls -A ${INSTALL_DIR})" ]; then
            bsddialog --default-no \
            --cancel-label "$(trans RETURN)" \
            --ok-label "$(trans OK)" \
            --yesno "$(trans WARN_DIR_NOT_EMPTY)(${INSTALL_DIR})" \
            0 0 \
            3>&2 2>&1 1>&3
            ANSWER=${?}
            case ${ANSWER} in
            0)
                ;;
            *)
                continue
                ;;
            esac
        fi
        break
    done

    echo -n ${INSTALL_DIR}
}

check_debootstrap(){
    if ! command -v debootstrap > /dev/null 2>&1; then
        bsddialog --yesno "$(trans INSTALL_DEBOOTSTRAP_OR_NOT)" 0 0 3>&2 2>&1 1>&3
        ANSWER=${?}
        case ${ANSWER} in
        0)
            echo $(trans INSTALL_DEBOOTSTRAP)
            pkg install -y debootstrap
            return 0
            ;;
        *)
            bsddialog --msgbox "$(trans INSTALL_FAILED_DEBOOTSTRAP_NOT_INSTALLED)"
            return 1
            ;;
        esac
    fi
    return 0
}