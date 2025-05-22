#!/usr/bin/env devmachine

KITTY_CONFIG_PATH="${KITTY_CONFIG_PATH:-$HOME/.config/kitty}"

case "$1" in

  setup)
    os::install "kitty"
    os::linkfile "$DEVFILES_PATH/kitty/kitty.conf" "$KITTY_CONFIG_PATH/kitty.conf"
    ;;

  reload)
    pkill -USR1 -f kitty
    ;;

  config)
    "$EDITOR" "$KITTY_CONFIG_PATH/kitty.conf"
    ;;

  --check-installed)
    command -v kitty &> /dev/null && echo yes
    ;;

  --check-version)
    kitty --version | cut -d ' ' -f 2
    ;;

esac
