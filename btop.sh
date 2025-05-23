#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "btop"
    ;;

  --check-installed)
    stdlib::test::iscommand btop && echo yes
    ;;

  --check-version)
    btop --version
    ;;

esac
