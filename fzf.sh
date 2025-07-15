#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "fzf"
  ;;

shellenv)
  eval "fzf --$2"
  ;;

--is-installed)
  stdlib_test command/exists fzf && echo yes
  ;;

esac
