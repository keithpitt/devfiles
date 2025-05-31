#!/usr/bin/env devmachine

case "$1" in

  shellenv)
    echo 'export EDITOR="nvim"'
    echo "edit() { \"\$EDITOR\" \"\$@\"; }"
    ;;

  --is-installed)
    echo "yes"

esac
