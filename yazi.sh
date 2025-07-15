#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "yazi"
  ;;

--is-installed)
  stdlib_test command/exists yazi && echo yes
  ;;

esac
