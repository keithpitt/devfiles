#!/usr/bin/env devmachine

case "$1" in

  install)
    os::install "iterm2"
    ;;

  import-color-schemes)
    temp_dir="$(mktemp -d)"
    os::sh cd "$temp_dir"
    os::download "https://github.com/mbadolato/iTerm2-Color-Schemes/archive/refs/heads/master.zip" "master.zip"
    unzip "master.zip"
    cd "iTerm2-Color-Schemes-master"
    tools/import-scheme.sh -v schemes/*
    ;;

esac
