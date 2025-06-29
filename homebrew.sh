#!/usr/bin/env devmachine

case "$1" in

logo)
  devicon "homebrew"
  ;;

setup)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ;;

shellenv)
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'

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

--is-installed)
  stdlib::test::is_command brew && echo yes
  ;;

esac
