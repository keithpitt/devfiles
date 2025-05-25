#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "fd"
    ;;

  --check-installed)
    stdlib::test::is_command fd && echo yes
    ;;

  --check-version)
    fd --version | cut -d ' ' -f 2
    ;;

esac
