#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "fd"
  ;;

--is-installed)
  stdlib_test_is_command fd && echo yes
  ;;

esac
