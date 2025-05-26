#!/usr/bin/env bash

if [[ "$QUICK_ACCESS" != "" ]]; then
echo 'include duckbones.conf'
else
echo 'include catppuccin-mocha.conf'
fi

