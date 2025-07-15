#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "git-delta"
  ;;

--is-installed)
  stdlib_test command/exists delta && echo yes
  ;;

esac
