#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "ripgrep"
  ;;

--is-installed)
  stdlib_test command/exists rg && echo yes
  ;;

esac
