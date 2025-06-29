#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "ripgrep"
  ;;

--is-installed)
  stdlib::test::is_command rg && echo yes
  ;;

esac
