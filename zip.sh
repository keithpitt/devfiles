#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "zip"
  ;;

--is-installed)
  stdlib_test_is_command zip && echo yes
  ;;

esac
