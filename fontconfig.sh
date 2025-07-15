#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "fontconfig"
  ;;

--is-installed)
  stdlib_test command/exists fc-list && echo yes
  ;;

esac
