#!/usr/bin/env devmachine

case "$1" in

logo)
  stdlib_image_print "bash/logo.png" 20 10
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
    cat "bash/history.bash"
    cat "bash/prompt.bash"
  else
    echo "# skipping bash shellenv"
  fi
  ;;

motd)
  source "bash/motd.bash"
  ;;

--is-installed)
  stdlib_test_is_command bash && echo yes
  ;;

esac
