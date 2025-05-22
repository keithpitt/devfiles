#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "httpie"
    ;;

  --check-installed)
    command -v httpie &> /dev/null && echo yes
    ;;

  --check-version)
    httpie --version
    ;;

esac
