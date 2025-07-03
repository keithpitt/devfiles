#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "unzip"
  ;;

--is-installed)
  stdlib_test_is_command unzip && echo yes
  ;;

esac
