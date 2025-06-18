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

  --check-version)
    gh --version | head -n 1 | cut -d ' ' -f 3
    ;;

esac
