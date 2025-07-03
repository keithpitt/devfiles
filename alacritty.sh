#!/usr/bin/env devmachine

ALACRITTY_CONFIG_PATH="${ALACRITTY_CONFIG_PATH:-$HOME/.config/alacritty}"

case "$1" in

setup)
  os::install "alacritty"
  @run configure
  ;;

configure)
  os::linkfile "alacritty" "$ALACRITTY_CONFIG_PATH"
  ;;

--is-installed)
  stdlib_test_is_dir "/Applications/Alacritty.app" && echo yes
  ;;

esac
