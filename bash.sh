#!/usr/bin/env devmachine

case "$1" in

  logo)
    stdlib::image::print "$DEVFILES_PATH/bash/logo.png" 20 10
    ;;

  setup)
    os::install "bash"
    ;;

  make-default)
    bash_path=$(which bash)
    grep -q "$bash_path" "/etc/shells" ||
      sudo sh -c "echo $bash_path >> /etc/shells"
    chsh -s "$bash_path"
    ;;

  shellenv)
    if [[ "$2" == "bash" ]]; then
      cat "$DEVFILES_PATH/bash/history.bash"
      cat "$DEVFILES_PATH/bash/prompt.bash"
    else
      echo "# skipping bash shellenv"
    fi
    ;;

  motd)
    source "$DEVFILES_PATH/bash/motd.bash"
    ;;

  --check-installed)
    command -v bash &> /dev/null && echo yes
    ;;

  --check-version)
    bash -c 'echo $BASH_VERSION'
    ;;

esac
