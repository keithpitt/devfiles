#!/usr/bin/env devmachine

GIT_CONFIG_PATH="${GIT_CONFIG_PATH:-$HOME/.config/git}"

case "$1" in

  setup)
    os::install "git"
    devfile::run configure
    ;;

  configure)
    os::linkfile "git/config" "$GIT_CONFIG_PATH/config"
    os::linkfile "git/ignore" "$GIT_CONFIG_PATH/ignore"
    ;;

  edit-config)
    "$EDITOR" "$GIT_CONFIG_PATH/config"
    ;;

  edit-ignore)
    "$EDITOR" "$GIT_CONFIG_PATH/ignore"
    ;;

  --is-installed)
    stdlib::test::is_command git && echo yes
    ;;

  --check-version)
    git --version | cut -d ' ' -f 3
    ;;

esac
