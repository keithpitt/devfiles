#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "btop"
  ;;

--is-installed)
  stdlib_test command/exists btop && echo yes
  ;;

esac
