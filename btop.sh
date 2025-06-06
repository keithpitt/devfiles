#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "btop"
    ;;

  --is-installed)
    stdlib::test::is_command btop && echo yes
    ;;

  --check-version)
    btop --version
    ;;

esac
