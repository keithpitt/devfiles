#!/usr/bin/env devmachine

case "$1" in

logo)
  stdlib_image_print "bash/logo.png" 20 10
  ;;

setup)
  os::install "bash"
  os::linkfile "bash/inputrc" "$HOME/.inputrc"
  ;;

make-default)
  bash_path=$(which bash)
  grep -q "$bash_path" "/etc/shells" ||
    sudo sh -c "echo $bash_path >> /etc/shells"
  chsh -s "$bash_path"
  ;;

shellenv)
  if [[ "$2" == "bash" ]]; then
    cat "bash/history.bash"
    cat "bash/prompt.bash"
    cat "bash/navigation.bash"
  else
    echo "# skipping bash shellenv"
  fi
  ;;

motd)
  source "bash/motd.bash"
  ;;

--is-installed)
  stdlib_test command/exists bash && echo yes
  ;;

esac
