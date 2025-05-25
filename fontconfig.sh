#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "fontconfig"
    ;;

  --is-installed)
    stdlib::test::is_command fc-list && echo yes
    ;;

  --check-version)
    # the vesion is sent to stderr not stdout
    fc-list --version 2>&1 >/dev/null | cut -d ' ' -f 3
    ;;

esac
