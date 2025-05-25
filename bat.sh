#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "bat"
    os::install "bat-extras"
    ;;

  shellenv)
    echo 'export BAT_THEME="ansi"'
    batman --export-env # batman is part of bat-extras
    ;;

  --check-installed)
    stdlib::test::is_command bat && echo yes
    ;;

  --check-version)
    bat --version | cut -d ' ' -f 2
    ;;

esac
