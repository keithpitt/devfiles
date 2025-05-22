#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "fastfetch"
    ;;

  --check-installed)
    command -v fastfetch &> /dev/null && echo yes
    ;;

  --check-version)
    fastfetch --version | cut -d ' ' -f 2
    ;;

esac
