#!/usr/bin/env devmachine

case "$1" in

  install)
    tempfile="$(mktemp)"
    os::download "https://github.com/idank/explainshell/releases/download/db-dump/dump.gz" "$tempfile"
    git clone https://github.com/idank/explainshell.git ~/.explainshell
    ;;

  --is-installed)
    stdlib::test::is_command docker && echo yes
    ;;

  --check-version)
    # eg: Docker version 25.0.5, build 5dc9bcc
    docker --version | head -1 | cut -d ' ' -f 3 | sed -e 's/[^0-9\.]//g'
    ;;

esac
