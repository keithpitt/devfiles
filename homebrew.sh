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

  if [[ "$2" == "bash" ]]; then
    echo '
    if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
      . "/opt/homebrew/etc/profile.d/bash_completion.sh"
    else
      echo "bash-completion@2 missing, installing now..."
      if ! brew install bash-completion@2 > /dev/null; then
        echo "❌ \`brew install bash-completion@2\` failed with exit code $?"
      else
        . "/opt/homebrew/etc/profile.d/bash_completion.sh"
      fi
    fi
    '
  fi
  ;;

--check-priority)
  echo "high"
  ;;

--check-eligible)
  [[ $(uname -s) == "Darwin" ]]
  ;;

--is-installed)
  stdlib_test command/exists brew && echo yes
  ;;

esac
