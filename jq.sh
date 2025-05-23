#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "jq"
    ;;

  --check-installed)
    stdlib::test::iscommand jq && echo yes
    ;;

  --check-version)
    jq --version
    ;;

esac
