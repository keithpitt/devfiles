#!/usr/bin/env devmachine

GHOSTTY_CONFIG_PATH="${GHOSTTY_CONFIG_PATH:-$HOME/.config/ghostty}"

case "$1" in

  logo)
    stdlib::image::print "$DEVFILES_PATH/ghostty/logo.png" 17 10
    ;;

  setup)
    os::install "ghostty"

    # https://github.com/ghostty-org/ghostty/pull/1102/files
    os::sh touch "$HOME/.hushlogin"

    devfile::run configure
    ;;

  configure)
    os::linkfile "$DEVFILES_PATH/ghostty/config" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  config)
    "$EDITOR" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  --check-installed)
    command -v ghostty &> /dev/null && echo yes
    ;;

  --check-version)
    ghostty --version | head -n 1 | sed 's/Ghostty //'
    ;;

esac
