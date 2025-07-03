#!/usr/bin/env devmachine

DIRCOLORS_CONFIG_PATH="${DIRCOLORS_CONFIG_PATH:-$HOME/.config/dircolors}"

case "$1" in

  install)
    os::install coreutils
    ;;

  configure)
    os::linkfile "dircolors" "$DIRCOLORS_CONFIG_PATH"
    ;;

  shellenv)
    gdircolors "$DIRCOLORS_CONFIG_PATH/dircolors.jellybeans"
    ;;

  --is-installed)
    stdlib_test_is_command gdircolors && echo yes
    ;;

esac
