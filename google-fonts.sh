#!/usr/bin/env devmachine

case "$1" in

  install)
    cd ~/Library/Fonts
    git clone --depth 1 https://github.com/google/fonts.git google-fonts
    ;;

esac
