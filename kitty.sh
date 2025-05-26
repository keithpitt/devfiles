#!/usr/bin/env devmachine

KITTY_CONFIG_PATH="${KITTY_CONFIG_PATH:-$HOME/.config/kitty}"

case "$1" in

  setup)
    os::install "kitty"
    devfile::run configure
    ;;

  configure)
    os::linkfile "kitty/kitty.conf" "$KITTY_CONFIG_PATH/kitty.conf"
    os::linkfile "kitty/themes" "$KITTY_CONFIG_PATH/themes"
    os::linkfile "kitty/kitty.app.icns" "$KITTY_CONFIG_PATH/kitty.app.icns"
    os::linkfile "kitty/quick-access-terminal.conf" "$KITTY_CONFIG_PATH/quick-access-terminal.conf"
    os::linkfile "kitty/duckbones.conf" "$KITTY_CONFIG_PATH/duckbones.conf"
    os::linkfile "kitty/catppuccin-mocha.conf" "$KITTY_CONFIG_PATH/catppuccin-mocha.conf"
    os::linkfile "kitty/theme_chooser.sh" "$KITTY_CONFIG_PATH/theme_chooser.sh"
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
    stdlib::test::is_command kitty && echo yes
    ;;

  --check-version)
    kitty --version | cut -d ' ' -f 2
    ;;

esac
