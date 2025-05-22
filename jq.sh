#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "jq"
    ;;

  --check-installed)
    command -v jq &> /dev/null && echo yes
    ;;

  --check-version)
    jq --version
    ;;

esac
