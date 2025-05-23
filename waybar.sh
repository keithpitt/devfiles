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
    which pacman > /dev/null &&
      pacman -Si waybar &> /dev/null
    ;;

  --check-installed)
    command -v waybar &> /dev/null && echo yes
    ;;

  --check-version)
    waybar --version | cut -d ' ' -f 2
    ;;

esac
