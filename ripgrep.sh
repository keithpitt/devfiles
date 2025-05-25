#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "ripgrep"
    ;;

  --check-installed)
    stdlib::test::is_command rg && echo yes
    ;;

  --check-version)
    rg --version | cut -d ' ' -f 2
    ;;

esac
