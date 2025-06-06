#!/usr/bin/env devmachine

case "$1" in

  setup)
    os::install "zip"
    ;;

  --is-installed)
    stdlib::test::is_command zip && echo yes
    ;;

  --check-version)
    zip --version |
      head -n 2 |
      tail -n 1 |
      sed -r 's:[^0-9\. ]*::g' |
      tr -s ' ' |
      cut -d ' ' -f 2
    ;;

esac
