#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "ripgrep"
  ;;

--is-installed)
  stdlib_test_is_command rg && echo yes
  ;;

esac
