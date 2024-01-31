#!/bin/sh

if echo ${LANG} | grep -q "^zh_CN"; then
    . ${DIR}/i18n/zh_CN.sh
else
    . ${DIR}/i18n/en_US.sh
fi


bsddialog --yesno "$(trans USE_ALI_DNS_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
0)
    bsddialog --msgbox "$(trans USE_ALI_DNS)\nnameserver 223.5.5.5" 0 0
    STATUS=${?}
    case ${STATUS} in
    0)
        ;;
    *)
        exit 2
        ;;
    esac
    echo "nameserver 223.5.5.5" > ${INSTALL_DIR}/etc/resolv.conf
    ;;
1)
    bsddialog --msgbox "$(trans USE_LOCAL_DNS)\n$(grep nameserver ${INSTALL_DIR}/etc/resolv.conf)" 0 0
    STATUS=${?}
    case ${STATUS} in
    0)
        ;;
    *)
        exit 2
        ;;
    esac
    cp -f /etc/resolv.conf ${INSTALL_DIR}/etc/resolv.conf
    ;;
*)
    exit 2
    ;;
esac

add_fstab(){
    bsddialog --msgbox "$(trans ADD_FSTAB)\n\
devfs       ${INSTALL_DIR}/dev      devfs       rw,late                     0   0\n\
tmpfs       ${INSTALL_DIR}/dev/shm  tmpfs       rw,late,size=1g,mode=1777   0   0\n\
fdescfs     ${INSTALL_DIR}/dev/fd   fdescfs     rw,late,linrdlnk            0   0\n\
linprocfs   ${INSTALL_DIR}/proc     linprocfs   rw,late                     0   0\n\
linsysfs    ${INSTALL_DIR}/sys      linsysfs    rw,late                     0   0\n\
/tmp        ${INSTALL_DIR}/tmp      nullfs      rw,late                     0   0" 0 0
    STATUS=${?}
    case ${STATUS} in
    0)
        ;;
    *)
        exit 2
        ;;
    esac
    echo "devfs	${INSTALL_DIR}/dev	devfs	rw,late	0	0" >> /etc/fstab
    echo "tmpfs	${INSTALL_DIR}/dev/shm	tmpfs	rw,late,size=1g,mode=1777	0	0" >> /etc/fstab
    echo "fdescfs	${INSTALL_DIR}/dev/fd	fdescfs	rw,late,linrdlnk	0	0" >> /etc/fstab
    echo "linprocfs	${INSTALL_DIR}/proc	linprocfs	rw,late	0	0" >> /etc/fstab
    echo "linsysfs	${INSTALL_DIR}/sys	linsysfs	rw,late	0	0" >> /etc/fstab
    echo "/tmp	${INSTALL_DIR}/tmp	nullfs	rw,late	0	0" >> /etc/fstab
    # echo "#/home	${INSTALL_DIR}/home	nullfs	rw,late	0	0" >> /etc/fstab
    mount -al
}

bsddialog --yesno "$(trans ADD_FSTAB_OR_NOT)" 0 0
ANSWER=${?}
case ${ANSWER} in
0)
    add_fstab
    ;;
1)
    bsddialog --default-no --yesno "$(trans CONTINUE_WITHOUT_FSTAB_ADDED)" 0 0
    ANSWER=${?}
    case ${ANSWER} in
    0)
        bsddialog --msgbox "$(trans WARN_FSTAB_NOT_ADDED)\n\
devfs       ${INSTALL_DIR}/dev      devfs       rw,late                     0   0\n\
tmpfs       ${INSTALL_DIR}/dev/shm  tmpfs       rw,late,size=1g,mode=1777   0   0\n\
fdescfs     ${INSTALL_DIR}/dev/fd   fdescfs     rw,late,linrdlnk            0   0\n\
linprocfs   ${INSTALL_DIR}/proc     linprocfs   rw,late                     0   0\n\
linsysfs    ${INSTALL_DIR}/sys      linsysfs    rw,late                     0   0\n\
/tmp        ${INSTALL_DIR}/tmp      nullfs      rw,late                     0   0" 0 0
        ;;
    1)
        add_fstab
        ;;
    *)
        exit 2
        ;;
    esac
    ;;
*)
    exit 2
    ;;
esac

exit 0
