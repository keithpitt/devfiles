#!/usr/bin/env devmachine

case "$1" in

  setup)
    curl https://mise.run | sh
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

  --check-version)
    echo $(mise version -q)
    ;;

esac
