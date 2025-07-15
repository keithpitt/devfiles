#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "fd"
  ;;

--is-installed)
  stdlib_test command/exists fd && echo yes
  ;;

esac
