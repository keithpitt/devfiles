#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "zsh"
    ;;

  make-default)
    zsh_path=$(which zsh)
    grep -q "$zsh_path" "/etc/shells" ||
      sudo sh -c "echo $zsh_path >> /etc/shells"
    chsh -s "$zsh_path"
    ;;

  shellenv)
    if [[ "$2" == "zsh" ]]; then
      cat "$DEVFILES_PATH/zsh/prompt.zsh"
      cat "$DEVFILES_PATH/zsh/completions.zsh"
      cat "$DEVFILES_PATH/zsh/history.zsh"
    else
      echo "# skipping zsh shellenv"
    fi
    ;;

  motd)
    exec "$DEVFILES_PATH/zsh/motd.zsh"
    ;;

  --check-installed)
    command -v zsh &> /dev/null && echo yes
    ;;

  --check-version)
    zsh --version | cut -d ' ' -f 2
    ;;

esac
