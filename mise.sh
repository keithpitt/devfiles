#!/usr/bin/env devmachine

case "$1" in

logo)
  devicon "mise"
  ;;

setup)
  os::sh curl https://mise.run | sh
  ;;

install-go)
  mise use -g go@latest
  ;;

install-ruby)
  mise use -g ruby@latest
  ;;

install-node)
  mise use -g node@latest
  ;;

install-python)
  mise use -g python@latest
  ;;

shellenv)
  mise activate "$2"
  ;;

--is-installed)
  # stdlib::test::is_command mise && echo yes
  echo yes
  ;;

esac
