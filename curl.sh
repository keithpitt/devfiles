#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "curl"
  ;;

--is-installed)
  stdlib_test command/exists curl && echo yes
  ;;

esac
