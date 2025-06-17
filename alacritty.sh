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
    stdlib::test::is_dir "/Applications/Alacritty.app" && echo yes
    ;;

  --check-version)
    kitty --version | cut -d ' ' -f 2
    grep "CFBundleShortVersionString" -A 1 /Applications/Alacritty.app/Contents/Info.plist | tail -n 1 | sed -Er "s/[a-zA-Z<>\/ ]+//g"
    ;;

esac
