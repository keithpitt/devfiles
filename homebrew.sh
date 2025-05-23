#!/usr/bin/env devmachine

case "$1" in

  logo)
    devicon "homebrew"
    ;;

  setup)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ;;

  shellenv)
    /opt/homebrew/bin/brew shellenv

    # man bash always shows the installed version of man, not the one
    # installed with homebrew. dunno why...
    echo 'alias brewman="man -M /opt/homebrew/share/man"'
    ;;

  --check-priority)
    echo "high"
    ;;

  --check-eligible)
    [[ $(uname -s) == "Darwin" ]]
    ;;

  --check-installed)
    stdlib::test::iscommand brew && echo yes
    ;;

  --check-version)
    brew --version | cut -d ' ' -f 2
    ;;

esac
