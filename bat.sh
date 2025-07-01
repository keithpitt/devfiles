#!/usr/bin/env devmachine

BAT_CONFIG_PATH="${BAT_CONFIG_PATH:-$HOME/.config/bat}"

case "$1" in

setup)
  os::install "bat"
  os::install "bat-extras"
  ;;

configure)
  os::linkfile "bat" "$BAT_CONFIG_PATH"
  bat cache --build
  ;;

shellenv)
  echo 'export BAT_THEME="ansi"'
  # batman --export-env # batman is part of bat-extras
  ;;

--is-installed)
  stdlib::test::is_command bat && echo yes
  ;;

esac
