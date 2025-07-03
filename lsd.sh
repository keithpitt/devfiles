#!/usr/bin/env devmachine

LSD_CONFIG_PATH="${LSD_CONFIG_PATH:-$HOME/.config/lsd}"

case "$1" in

setup)
  os::install "lsd"
  os::linkfile "lsd/config.yaml" "$LSD_CONFIG_PATH/config.yaml"
  ;;

edit-config)
  "$EDITOR" "$LSD_CONFIG_PATH/config.yaml"
  ;;

shellenv)
  echo 'alias ls="lsd"'
  ;;

--is-installed)
  stdlib_test_is_command lsd && echo yes
  ;;

esac
