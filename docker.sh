#!/usr/bin/env bash

case "$1" in

logo)
  devicon "docker"
  ;;

setup)
  os::install "docker"
  ;;

--is-installed)
  stdlib_test_is_command docker && echo yes
  ;;

esac
