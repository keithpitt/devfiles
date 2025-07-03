#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "fontconfig"
  ;;

--is-installed)
  stdlib_test_is_command fc-list && echo yes
  ;;

esac
