#!/usr/bin/env devmachine

case "$1" in

  install)
    os::download "https://github.com/zen-browser/desktop/releases/latest/download/zen.macos-universal.dmg"
    ;;

esac
