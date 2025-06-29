#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "netcat"
  ;;

--is-installed)
  stdlib::test::is_command netcat && echo yes
  ;;

esac
