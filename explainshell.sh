#!/usr/bin/env devmachine

case "$1" in

install)
  tempfile="$(mktemp)"
  os::download "https://github.com/idank/explainshell/releases/download/db-dump/dump.gz" "$tempfile"
  git clone https://github.com/idank/explainshell.git ~/.explainshell
  ;;

--is-installed)
  stdlib_test command/exists docker && echo yes
  ;;

esac
