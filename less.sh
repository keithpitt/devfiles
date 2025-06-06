#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "less"
    ;;

  shellenv)
    # -w
    #   automatically go back to the start of the file
    #   when it's finished searching
    # -i
    #   ignore case unless there's an uppercase letter
    #   in the search
    # -R
    #   make colors work
    echo 'export LESS="-w -i -R"'
    ;;

  --is-installed)
    stdlib::test::is_command less && echo yes
    ;;

  --check-version)
    less --version | head -n 1 | cut -d ' ' -f 2
    ;;

esac
