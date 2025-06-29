#!/usr/bin/env devmachine

case "$1" in

setup)
  os::install "zip"
  ;;

--is-installed)
  stdlib::test::is_command zip && echo yes
  ;;

esac
