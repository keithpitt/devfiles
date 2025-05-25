#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "fzf"
    ;;

  shellenv)
    eval "fzf --$2"
    ;;

  --check-installed)
    stdlib::test::is_command fzf && echo yes
    ;;

  --check-version)
    fzf --version
    ;;

esac
