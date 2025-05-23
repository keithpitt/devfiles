#!/usr/bin/env devtool

case "$1" in

  --check-installed)
    stdlib::test::iscommand irb && echo yes
    ;;

  --check-version)
    irb --version | cut -d ' ' -f 2
    ;;

esac
