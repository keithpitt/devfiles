#!/usr/bin/env bash

case "$1" in

  logo)
    devicon "docker"
    ;;

  setup)
    os::install "docker"
    ;;

  --is-installed)
    stdlib::test::is_command docker && echo yes
    ;;

  --check-version)
    # eg: Docker version 25.0.5, build 5dc9bcc
    docker --version | head -1 | cut -d ' ' -f 3 | sed -e 's/[^0-9\.]//g'
    ;;

esac
