#!/usr/bin/env devmachine

SKHD_CONFIG_PATH="${SKHD_CONFIG_PATH:-$HOME/.config/skhd}"

case "$1" in

install)
  brew install koekeishiya/formulae/skhd
  skhd --install-service
  ;;

configure)
  os::linkfile "skhd/skhdrc" "$SKHD_CONFIG_PATH/skhdrc"
  skhd -r 2>/dev/null || skhd --start-service
  ;;

--is-installed)
  stdlib_test_is_command skhd && echo yes
  ;;

esac
