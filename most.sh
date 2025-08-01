#!/usr/bin/env devmachine

# if type most &> /dev/null; then
#   export PAGER=most
# else
#   echo "install most"
#   # # -w so it'll automatically go back to the start of the file
#   # # when it's finished searching
#   # #
#   # # and --raw-control-chars so we can do colors
#   # export LESS="-w --raw-control-chars"
#   #
#   # export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
#   # export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
#   # export LESS_TERMCAP_me=$(tput sgr0)
#   # export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
#   # export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
#   # export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
#   # export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
#   # export LESS_TERMCAP_mr=$(tput rev)
#   # export LESS_TERMCAP_mh=$(tput dim)
#   # export LESS_TERMCAP_ZN=$(tput ssubm)
#   # export LESS_TERMCAP_ZV=$(tput rsubm)
#   # export LESS_TERMCAP_ZO=$(tput ssupm)
#   # export LESS_TERMCAP_ZW=$(tput rsupm)
#   # export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal
# fi

case "$1" in

setup)
  os::install "most"
  ;;

--is-installed)
  stdlib_test command/exists most && echo yes
  ;;

esac
