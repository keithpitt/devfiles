#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "curl"
  ;;

--is-installed)
  stdlib::test::is_command curl && echo yes
  ;;

esac
