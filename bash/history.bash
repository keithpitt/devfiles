# Ignore and erase duplicates
HISTCONTROL="ignoreboth:erasedups"

# Ignore one and two letter commands
HISTIGNORE="?:??"

export HISTDIR="$XDG_STATE_HOME/bash"
export HISTFILE="$HISTDIR/history"
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

mkdir -p "$HISTDIR"

# By default bash will wipe out the history file each time you start
# a new bash session (which is very annoying when you open multiple
# windows). `histappend` tells bash to add to the current history
# file instead of wiping it
shopt -s histappend

# Save history right away, instead of waiting for bash to exit
# PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
# I had this turned on, but it ended up being really quite annoying and
# confusing
