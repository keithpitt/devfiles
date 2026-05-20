#!/usr/bin/env devmachine

GIT_CONFIG_PATH="${GIT_CONFIG_PATH:-$HOME/.config/git}"

case "$1" in

setup)
  os::install "git"
  devfile::run configure
  ;;

configure)
  os::linkfile "git/config" "$GIT_CONFIG_PATH/shared"
  os::linkfile "git/ignore" "$GIT_CONFIG_PATH/ignore"
  os::linkfile "git/hooks" "$GIT_CONFIG_PATH/hooks"

  # ~/.config/git/config is a thin local file that includes the tracked
  # dotfile (~/.config/git/shared) and the per-machine user file. Tools
  # that auto-edit the global config (1Password, `git lfs install`, etc.)
  # write here, leaving the tracked dotfile clean.
  if [ ! -f "$GIT_CONFIG_PATH/config" ] || [ -L "$GIT_CONFIG_PATH/config" ]; then
    rm -f "$GIT_CONFIG_PATH/config"
    cat >"$GIT_CONFIG_PATH/config" <<'EOF'
[include]
    path = ~/.config/git/shared

[include]
    path = ~/.config/git/user
EOF
  fi

  if [ ! -f "$GIT_CONFIG_PATH/user" ]; then
    echo "please run: devmachine git setuser"
    echo "please run: devmachine git setuser" >"$GIT_CONFIG_PATH/user"
  fi

  ;;

edit-config)
  "$EDITOR" "$GIT_CONFIG_PATH/config"
  ;;

edit-ignore)
  "$EDITOR" "$GIT_CONFIG_PATH/ignore"
  ;;

setuser)
  read -r -p "full name: " name
  read -r -p "email: " email

  rm "$GIT_CONFIG_PATH/user"
  echo "[user]" >>"$GIT_CONFIG_PATH/user"
  echo "  email = $email" >>"$GIT_CONFIG_PATH/user"
  echo "  name = $name" >>"$GIT_CONFIG_PATH/user"

  echo "Saved to $GIT_CONFIG_PATH/user"
  cat "$GIT_CONFIG_PATH/user"
  ;;

--is-installed)
  stdlib_test command/exists git && echo yes
  ;;

esac
