#!/usr/bin/env devtool

case "$1" in

--is-installed)
  stdlib_test command/exists irb && echo yes
  ;;

esac
