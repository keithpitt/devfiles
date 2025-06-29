#!/usr/bin/env devmachine

case "$1" in

setup)
  brew install fontconfig
  brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs brew install --cask
  ;;

--is-installed)
  test -e "$HOME/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf" && echo "yes"
  ;;

esac
