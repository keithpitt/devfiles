#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "zoxide"
  ;;

shellenv)
  zoxide init "$2" --cmd "j"
  ;;

--is-installed)
  stdlib_test_is_command zoxide && echo yes
  ;;

esac
