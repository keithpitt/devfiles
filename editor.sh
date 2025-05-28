#!/usr/bin/env devmachine

case "$1" in

  shellenv)
    echo 'export EDITOR="nvim"'
    echo "export -f edit() { \"\$EDITOR\" \"\$@\"; }"
    ;;

  --is-installed)
    echo "yes"

esac
