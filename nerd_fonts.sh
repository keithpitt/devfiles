#!/usr/bin/env devmachine

case "$1" in

  setup)
    brew install fontconfig
    brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs brew install --cask
    ;;

  --check-installed)
    test -e "$HOME/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf" && echo "yes"
    ;;

  --check-version)
    fc-query -f '%{fontversion}\n' "$HOME/Library/Fonts/JetBrainsMonoNerdFont-Regular.ttf" |
      awk '{printf "%.3f\n", $1/65536.0}'
    ;;

esac
