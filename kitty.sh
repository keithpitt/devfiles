#!/usr/bin/env devmachine

KITTY_CONFIG_PATH="${KITTY_CONFIG_PATH:-$HOME/.config/kitty}"

case "$1" in

setup)
  os::install "kitty"
  @run configure
  ;;

configure)
  os::linkfile "kitty" "$KITTY_CONFIG_PATH"
  ;;

reload)
  pkill -USR1 -f kitty
  ;;

theme-browser)
  kitty +kitten themes --reload-in=all
  ;;

config)
  "$EDITOR" "$KITTY_CONFIG_PATH/kitty.conf"
  ;;

--is-installed)
  stdlib_test command/exists kitty && echo yes
  ;;

esac
