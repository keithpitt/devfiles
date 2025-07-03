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

--is-installed)
  stdlib_test_is_command ghostty && echo yes
  ;;

esac
