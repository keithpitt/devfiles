#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "httpie"
  ;;

--is-installed)
  stdlib_test_is_command httpie && echo yes
  ;;

esac
