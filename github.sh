#!/usr/bin/env devmachine

case "$1" in

install)
  os::install "gh"
  ;;

configure)
  if ! gh auth status; then
    os::sh gh auth login
  fi

  os::sh gh auth setup-git
  ;;

--is-installed)
  stdlib::test::is_command gh && echo yes
  ;;

esac
