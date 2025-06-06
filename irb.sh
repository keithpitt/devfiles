#!/usr/bin/env devtool

case "$1" in

  --is-installed)
    stdlib::test::is_command irb && echo yes
    ;;

  --check-version)
    irb --version | cut -d ' ' -f 2
    ;;

esac
