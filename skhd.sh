#!/usr/bin/env devmachine

SKHD_CONFIG_PATH="${SKHD_CONFIG_PATH:-$HOME/.config/skhd}"

case "$1" in

  install)
    brew install koekeishiya/formulae/skhd
    skhd --install-service
    skhd --start-service
    ;;

  configure)
    os::linkfile "skhd/skhdrc" "$SKHD_CONFIG_PATH/skhdrc"
    skhd -r
    ;;

  --is-installed)
    stdlib::test::is_command rg && echo yes
    ;;

  --check-version)
    skhd --version | cut -d ' ' -f 2
    ;;

esac
