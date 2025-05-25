#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "git-delta"
    ;;

  --check-installed)
    stdlib::test::is_command delta && echo yes
    ;;

  --check-version)
    delta --version | cut -d ' ' -f 2
    ;;

esac
