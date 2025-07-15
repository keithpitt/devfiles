#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "unzip"
  ;;

--is-installed)
  stdlib_test command/exists unzip && echo yes
  ;;

esac
