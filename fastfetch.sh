#!/usr/bin/env devmachine

case "$1" in

setup)
  # os
  os::install "fastfetch"
  ;;

--is-installed)
  stdlib::test::is_command fastfetch && echo yes
  ;;

esac
