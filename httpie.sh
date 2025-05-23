#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "httpie"
    ;;

  --check-installed)
    stdlib::test::iscommand httpie && echo yes
    ;;

  --check-version)
    httpie --version
    ;;

esac
