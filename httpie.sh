#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "httpie"
  ;;

--is-installed)
  stdlib_test command/exists httpie && echo yes
  ;;

esac
