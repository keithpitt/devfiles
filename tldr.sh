#!/usr/bin/env devmachine

# fyi: tldr is deprecated, tldc is the rust rewrite but its the same thing

case "$1" in

  setup)
    os::install "tldc"
    ;;

  --check-installed)
    stdlib::test::is_command tldc && echo yes
    ;;

  --check-version)
    tldc --version | cut -d ' ' -f 2
    ;;

esac
