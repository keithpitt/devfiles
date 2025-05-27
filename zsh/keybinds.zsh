# https://github.com/ghostty-org/ghostty/issues/1850
if [[ "$TERM" =* "ghostty" ]]; then
    bindkey ';2;13~' accept-line
    bindkey ';5;13~' accept-line
fi
