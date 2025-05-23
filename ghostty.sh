#!/usr/bin/env devmachine

GHOSTTY_CONFIG_PATH="${GHOSTTY_CONFIG_PATH:-$HOME/.config/ghostty}"

case "$1" in

  logo)
    devicon "ghostty"
    ;;

  setup)
    os::install "ghostty"

    # https://github.com/ghostty-org/ghostty/pull/1102/files
    os::sh touch "$HOME/.hushlogin"

    devfile::run configure
    ;;

  configure)
    os::linkfile "ghostty/config" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  config)
    "$EDITOR" "$GHOSTTY_CONFIG_PATH/config"
    ;;

  --check-installed)
    stdlib::test::iscommand ghostty && echo yes
    ;;

  --check-version)
    ghostty --version | head -n 1 | sed 's/Ghostty //'
    ;;

esac
