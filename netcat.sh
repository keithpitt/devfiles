#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "netcat"
    ;;

  --check-installed)
    stdlib::test::iscommand netcat && echo yes
    ;;

  --check-version)
    netcat --version
    ;;

esac
