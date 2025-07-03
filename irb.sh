#!/usr/bin/env devtool

case "$1" in

--is-installed)
  stdlib_test_is_command irb && echo yes
  ;;

esac
