#!/usr/bin/env devmachine

case "$1" in

  install)
    os::install "yubikey-manager"
    systemctl enable pcscd.socket
    systemctl enable pcscd.service
    ;;

esac
