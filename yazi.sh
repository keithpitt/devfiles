#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "yazi"
  ;;

--is-installed)
  stdlib_test_is_command yazi && echo yes
  ;;

esac
