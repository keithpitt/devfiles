#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "ripgrep"
    ;;

  --check-installed)
    stdlib::test::iscommand rg && echo yes
    ;;

  --check-version)
    rg --version | cut -d ' ' -f 2
    ;;

esac
