#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_FEDORA_TYPE")
        echo "Choose Fedora type:"
        ;;
    "MINIMAL_NOT_RECOMMENDED")
        echo "(Not recommend. Does not have dnf.)"
        ;;
    "RETURN")
        echo "Return to previous menu"
        ;;
    "REQUIRE_CHOICE")
        echo "Enter your choice:"
        ;;
    *)
        echo ${1}
        ;;
    esac
}
