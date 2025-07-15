#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "zip"
  ;;

--is-installed)
  stdlib_test command/exists zip && echo yes
  ;;

esac
