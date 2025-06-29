#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "unzip"
  ;;

--is-installed)
  stdlib::test::is_command unzip && echo yes
  ;;

esac
