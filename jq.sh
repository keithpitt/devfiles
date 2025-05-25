#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "jq"
    ;;

  --is-installed)
    stdlib::test::is_command jq && echo yes
    ;;

  --check-version)
    jq --version
    ;;

esac
