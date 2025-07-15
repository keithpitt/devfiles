#!/usr/bin/env bash

case "$1" in

logo)
  devicon "docker"
  ;;

setup)
  os::install "docker"
  ;;

--is-installed)
  stdlib_test command/exists docker && echo yes
  ;;

esac
