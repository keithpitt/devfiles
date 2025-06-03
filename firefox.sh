#!/usr/bin/env devmachine

case "$1" in

  logo)
    devicon "firefox"
    ;;

  install)
    os::install "firefox"
    ;;

esac
