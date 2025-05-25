#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "unzip"
    ;;

  --check-installed)
    stdlib::test::is_command unzip && echo yes
    ;;

  --check-version)
    unzip -v |
      head -n 1 |
      cut -d ' ' -f 2
    ;;

esac
