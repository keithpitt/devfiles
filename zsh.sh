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
      cat "zsh/setup.zsh"
      cat "zsh/keybinds.zsh"
      cat "zsh/prompt.zsh"
      cat "zsh/completions.zsh"
      cat "zsh/history.zsh"
    else
      echo "# skipping zsh shellenv"
    fi
    ;;

  motd)
    exec "zsh/motd.zsh"
    ;;

  --is-installed)
    stdlib::test::is_command zsh && echo yes
    ;;

  --check-version)
    zsh --version | cut -d ' ' -f 2
    ;;

esac
