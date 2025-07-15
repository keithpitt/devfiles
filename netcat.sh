#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "netcat"
  ;;

--is-installed)
  stdlib_test command/exists netcat && echo yes
  ;;

esac
