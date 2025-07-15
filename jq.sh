#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "jq"
  ;;

--is-installed)
  stdlib_test command/exists jq && echo yes
  ;;

esac
