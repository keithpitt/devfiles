#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "yazi"
    ;;

  --check-installed)
    stdlib::test::iscommand yazi && echo yes
    ;;

  --check-version)
    yazi --version | cut -d ' ' -f 2
    ;;

esac
