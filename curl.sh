#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "curl"
    ;;

  --check-installed)
    stdlib::test::iscommand curl && echo yes
    ;;

  --check-version)
    curl --version | head -1 | cut -d ' ' -f 2
    ;;

esac
