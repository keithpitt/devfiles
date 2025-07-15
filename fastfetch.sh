#!/usr/bin/env devmachine

case "$1" in

setup)
  # os
  os::install "fastfetch"
  ;;

--is-installed)
  stdlib_test command/exists fastfetch && echo yes
  ;;

esac
