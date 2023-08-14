#!/bin/sh

tr () {
    case ${1} in
    "CHOOSE_GENTOO_TYPE")
        echo "Choose Gentoo type: "
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
