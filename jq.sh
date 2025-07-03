#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "jq"
  ;;

--is-installed)
  stdlib_test_is_command jq && echo yes
  ;;

esac
