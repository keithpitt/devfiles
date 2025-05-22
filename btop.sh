#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "btop"
    ;;

  --check-installed)
    command -v btop &> /dev/null && echo yes
    ;;

  --check-version)
    btop --version
    ;;

esac
