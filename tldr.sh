#!/usr/bin/env devmachine

# fyi: tldr is deprecated, tldc is the rust rewrite but its the same thing

case "$1" in

setup)
  os::install "tldc"
  ;;

--is-installed)
  stdlib_test command/exists tldc && echo yes
  ;;

esac
