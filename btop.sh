#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "btop"
  ;;

--is-installed)
  stdlib_test_is_command btop && echo yes
  ;;

esac
