g() {
  local debug=0
  if [[ "$1" == "--debug" ]]; then
    debug=1
    shift
  fi

  local aliases_dir="${XDG_DATA_HOME:-$HOME/.local/share}/g"
  local aliases_file="$aliases_dir/aliases"

  if [[ "$1" == "+aliases" ]]; then
    shift
    local sub=$1
    [[ $# -gt 0 ]] && shift
    case "$sub" in
      list)
        if [[ ! -s "$aliases_file" ]]; then
          echo "g: no aliases defined"
          return 0
        fi
        local a_name a_path
        while IFS=$'\t' read -r a_name a_path; do
          [[ -z "$a_name" ]] && continue
          printf "  %-20s  %s\n" "$a_name" "$a_path"
        done < "$aliases_file"
        return 0
        ;;
      add)
        if [[ $# -lt 2 ]]; then
          echo "g: usage: g +aliases add [name] [path]" >&2
          return 1
        fi
        local new_name=$1 new_path=$2
        if [[ "$new_name" == *$'\t'* ]]; then
          echo "g: alias name cannot contain tab characters" >&2
          return 1
        fi
        local new_lname="${new_name:l}"
        if [[ "$new_path" == "~" ]]; then
          new_path="$HOME"
        elif [[ "$new_path" == "~/"* ]]; then
          new_path="$HOME/${new_path#\~/}"
        fi
        new_path="${new_path:A}"
        if [[ ! -d "$new_path" ]]; then
          echo "g: warning: path does not exist or is not a directory: $new_path" >&2
        fi
        mkdir -p "$aliases_dir"
        local tmp="$aliases_file.tmp.$$"
        : > "$tmp"
        if [[ -f "$aliases_file" ]]; then
          local a_name a_path
          while IFS=$'\t' read -r a_name a_path; do
            [[ -z "$a_name" ]] && continue
            [[ "${a_name:l}" == "$new_lname" ]] && continue
            printf '%s\t%s\n' "$a_name" "$a_path" >> "$tmp"
          done < "$aliases_file"
        fi
        printf '%s\t%s\n' "$new_name" "$new_path" >> "$tmp"
        mv "$tmp" "$aliases_file"
        echo "g: alias '$new_name' → $new_path"
        return 0
        ;;
      "")
        echo "g: usage: g +aliases [list|add]" >&2
        return 1
        ;;
      *)
        echo "g: unknown +aliases subcommand: $sub" >&2
        echo "g: usage: g +aliases [list|add]" >&2
        return 1
        ;;
    esac
  fi

  if [[ $# -eq 0 ]]; then
    if (( debug )); then
      echo "g: --debug requires a name" >&2
      return 1
    fi
    local root
    root=$(git rev-parse --show-toplevel 2>/dev/null) || {
      echo "g: not inside a git repository" >&2
      return 1
    }
    cd "$root"
    return
  fi

  local name=$1 base candidate

  if [[ -f "$aliases_file" ]]; then
    local lname="${name:l}"
    local a_name a_path
    while IFS=$'\t' read -r a_name a_path; do
      [[ -z "$a_name" ]] && continue
      if [[ "${a_name:l}" == "$lname" ]]; then
        if (( debug )); then
          echo "g: alias '$a_name' matched (highest priority)" >&2
          echo "g: would cd to $a_path" >&2
          return 0
        fi
        cd "$a_path"
        return
      fi
    done < "$aliases_file"
  fi

  for base in "$HOME/Code" "$HOME/Work"; do
    candidate="$base/$name"
    if [[ -d "$candidate" ]]; then
      if (( debug )); then
        echo "g: depth-1 exact-name shortcut matched (bypasses tier system)" >&2
        echo "g: would cd to $candidate" >&2
        return 0
      fi
      cd "$candidate"
      return
    fi
  done

  local -a exact_d2 prefix_d1 prefix_d2 substr_d1 substr_d2
  local p
  for base in "$HOME/Code" "$HOME/Work"; do
    [[ -d "$base" ]] || continue
    for p in "$base"/*/"$name"(N/);   do [[ -e "$p/.git" ]] && exact_d2+=("$p");  done
    for p in "$base"/"$name"*(N/);    do [[ -e "$p/.git" ]] && prefix_d1+=("$p"); done
    for p in "$base"/*/"$name"*(N/);  do [[ -e "$p/.git" ]] && prefix_d2+=("$p"); done
    for p in "$base"/*"$name"*(N/);   do [[ -e "$p/.git" ]] && substr_d1+=("$p"); done
    for p in "$base"/*/*"$name"*(N/); do [[ -e "$p/.git" ]] && substr_d2+=("$p"); done
  done

  # Dedupe: each path stays only in its best (lowest-numbered) tier.
  local -A seen
  local arr_name cand
  local -a filtered
  for arr_name in exact_d2 prefix_d1 prefix_d2 substr_d1 substr_d2; do
    filtered=()
    for cand in "${(P@)arr_name}"; do
      [[ -n "${seen[$cand]}" ]] && continue
      seen[$cand]=1
      filtered+=("$cand")
    done
    set -A "$arr_name" "${filtered[@]}"
  done

  local winner=""
  if   (( ${#exact_d2[@]}  > 0 )); then winner="${exact_d2[1]}"
  elif (( ${#prefix_d1[@]} > 0 )); then winner="${prefix_d1[1]}"
  elif (( ${#prefix_d2[@]} > 0 )); then winner="${prefix_d2[1]}"
  elif (( ${#substr_d1[@]} > 0 )); then winner="${substr_d1[1]}"
  elif (( ${#substr_d2[@]} > 0 )); then winner="${substr_d2[1]}"
  fi

  if (( debug )); then
    local total=$(( ${#exact_d2[@]} + ${#prefix_d1[@]} + ${#prefix_d2[@]} + ${#substr_d1[@]} + ${#substr_d2[@]} ))
    if (( total == 0 )); then
      echo "g: no folder matching '$name' found under ~/Code or ~/Work" >&2
      return 1
    fi
    echo "g: candidates for '$name' ($total found)" >&2
    printf "  %-4s  %s\n" "tier" "path" >&2
    local marker tier=0
    for arr_name in exact_d2 prefix_d1 prefix_d2 substr_d1 substr_d2; do
      tier=$((tier+1))
      for cand in "${(P@)arr_name}"; do
        marker=""
        [[ "$cand" == "$winner" ]] && marker="  <—"
        printf "  %-4d  %s%s\n" "$tier" "$cand" "$marker" >&2
      done
    done
    echo "g: would cd to $winner" >&2
    echo "g: tiers — 1=exact d2, 2=prefix d1, 3=prefix d2, 4=substr d1, 5=substr d2" >&2
    return 0
  fi

  if [[ -n "$winner" ]]; then
    cd "$winner"
    return
  fi

  echo "g: no folder matching '$name' found under ~/Code or ~/Work" >&2
  return 1
}

_g() {
  local aliases_file="${XDG_DATA_HOME:-$HOME/.local/share}/g/aliases"
  local -a alias_list repo_list
  local base p a_name a_path

  case $CURRENT in
    2)
      if [[ ${words[2]} == +* ]]; then
        compadd -- '+aliases'
        return
      fi
      if [[ -f "$aliases_file" ]]; then
        while IFS=$'\t' read -r a_name a_path; do
          [[ -n "$a_name" ]] && alias_list+=("$a_name")
        done < "$aliases_file"
      fi
      for base in "$HOME/Code" "$HOME/Work"; do
        [[ -d "$base" ]] || continue
        for p in "$base"/*(N/);   do repo_list+=("${p:t}"); done
        for p in "$base"/*/*(N/); do [[ -e "$p/.git" ]] && repo_list+=("${p:t}"); done
      done
      repo_list=(${(u)repo_list})
      _alternative \
        'aliases:alias:compadd -a alias_list' \
        'repos:repository:compadd -a repo_list' \
        'subcmds:subcommand:compadd -- +aliases'
      ;;
    3)
      [[ ${words[2]} == "+aliases" ]] && compadd -- list add
      ;;
    5)
      [[ ${words[2]} == "+aliases" && ${words[3]} == "add" ]] && _files -/
      ;;
  esac
}
compdef _g g 2>/dev/null
