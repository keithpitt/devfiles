#!/usr/bin/env devmachine

WAYBAR_CONFIG_PATH="${WAYBAR_CONFIG_PATH:-$HOME/.config/waybar}"

case "$1" in

setup)
  os::install "waybar"
  devfile::run configure
  ;;

configure)
  os::linkfile "waybar" "$WAYBAR_CONFIG_PATH"
  ;;

--check-eligible)
  which pacman >/dev/null &&
    pacman -Si waybar &>/dev/null
  ;;

--is-installed)
  stdlib::test::is_command waybar && echo yes
  ;;

esac
