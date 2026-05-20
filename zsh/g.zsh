# --- the `g` jumper: one smart resolver over aliases, folders, branches & worktrees

# EPOCHSECONDS, used to timestamp history entries. Best-effort: if the module
# is unavailable the timestamp falls back to 0 and recency still works (the
# history file's line order is the real recency signal).
zmodload zsh/datetime 2>/dev/null

# Local branch names, most-recently-checked-out first. Recency comes straight
# from HEAD's reflog, so no separate history file is needed — git already
# records every `checkout`/`switch`. Branches never checked out follow, in
# git's own order. Stale reflog entries (deleted branches) are dropped.
__g_branches() {
  emulate -L zsh
  local -a all ordered reflog
  local -A exists added
  local b entry
  all=( ${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null)"} )
  for b in "${all[@]}"; do
    [[ -n "$b" ]] && exists[$b]=1
  done
  reflog=( ${(f)"$(git reflog --format='%gs' 2>/dev/null)"} )
  for entry in "${reflog[@]}"; do
    [[ "$entry" == "checkout: moving from "*" to "* ]] || continue
    b="${entry##* to }"
    [[ -n "$b" && -n "${exists[$b]}" && -z "${added[$b]}" ]] || continue
    added[$b]=1
    ordered+=("$b")
  done
  for b in "${all[@]}"; do
    [[ -n "$b" && -z "${added[$b]}" ]] || continue
    added[$b]=1
    ordered+=("$b")
  done
  (( ${#ordered[@]} )) && print -rl -- "${ordered[@]}"
}

# One line per worktree: "<path><TAB><branch>" (branch empty when detached).
# Each entry is flushed when the next "worktree " line arrives — the porcelain
# blank-line separators can't be relied on, since ${(f)} drops empty fields.
__g_worktrees() {
  emulate -L zsh
  local -a lines
  local line wt_path="" wt_branch=""
  lines=( ${(f)"$(git worktree list --porcelain 2>/dev/null)"} )
  for line in "${lines[@]}" "worktree "; do
    case "$line" in
      "worktree "*)
        [[ -n "$wt_path" ]] && print -r -- "${wt_path}"$'\t'"${wt_branch}"
        wt_path="${line#worktree }"
        wt_branch=""
        ;;
      "branch "*) wt_branch="${line#branch refs/heads/}" ;;
    esac
  done
}

# `cd` wrapper that records a one-step undo target before moving, so `g -`
# can return here. The _G_UNDO_* globals are session-scoped — they live only
# in this shell. Recording is skipped when we'd "move" to the current dir.
__g_cd() {
  emulate -L zsh
  local dest=$1
  if [[ -d "$dest" && ! "$dest" -ef "$PWD" ]]; then
    _G_UNDO_KIND=dir
    _G_UNDO_DIR=$PWD
    _G_UNDO_BRANCH=""
    _G_UNDO_REPO=""
  fi
  cd "$dest"
}

# Branch switch used by `g` when it resolves to a branch (mode "carry", the
# default) and by `g -` (mode "safe"). Plain `git switch` already carries
# uncommitted changes when they don't clash with the target branch. On a clash:
# "carry" mode stashes, switches, and pops — announcing each step; "safe" mode
# refuses and changes nothing, since an undo shouldn't itself trigger a stash
# dance. Records a one-step undo on success.
__g_switch() {
  emulate -L zsh
  local target=$1 mode=${2:-carry}
  local cur repo out pop_out switched=0 rc=0
  cur=$(git symbolic-ref --short -q HEAD 2>/dev/null)
  repo=$(git rev-parse --show-toplevel 2>/dev/null)

  if [[ -n "$cur" && "$target" == "$cur" ]]; then
    echo "g: already on '$target'"
    return 0
  fi

  if out=$(git switch "$target" 2>&1); then
    switched=1
    [[ -n "$out" ]] && print -r -- "$out"
  elif [[ -z "$(git status --porcelain 2>/dev/null)" ]]; then
    # Switch failed with a clean tree → an unrelated error; surface it as-is.
    print -r -- "$out" >&2
    return 1
  elif [[ "$mode" == safe ]]; then
    # An undo (`g -`) hit a clash. Don't auto-stash as part of an undo —
    # surface it and leave everything untouched for the user to decide.
    echo "g: not undoing — switching to '$target' would clash with your uncommitted changes." >&2
    echo "g: nothing changed. commit or stash them, or run 'g $target' to carry them across." >&2
    return 1
  else
    echo "g: '$target' clashes with your uncommitted changes — bringing them along…"
    if ! git stash push -u -m "g: carry to $target" >/dev/null 2>&1; then
      echo "g: could not stash your changes; staying on '${cur:-the current branch}'" >&2
      return 1
    fi
    if out=$(git switch "$target" 2>&1); then
      switched=1
      [[ -n "$out" ]] && print -r -- "$out"
      if pop_out=$(git stash pop 2>&1); then
        echo "g: brought your changes across to '$target'"
      else
        print -r -- "$pop_out" >&2
        echo "g: switched to '$target', but restoring your changes hit conflicts —" >&2
        echo "g: resolve them; your work is also kept safe in 'git stash'." >&2
        rc=1
      fi
    else
      git stash pop >/dev/null 2>&1
      print -r -- "$out" >&2
      echo "g: could not switch to '$target'; your changes were restored." >&2
      return 1
    fi
  fi

  if (( switched )) && [[ -n "$cur" ]]; then
    _G_UNDO_KIND=branch
    _G_UNDO_BRANCH=$cur
    _G_UNDO_REPO=$repo
    _G_UNDO_DIR=""
  fi
  return $rc
}

# --- state files: recency history + learned disambiguation decisions --------
# Both live under $XDG_DATA_HOME/g alongside the alias file, are tab-separated,
# and are rewritten atomically (write a .tmp.$$ then `mv`) — the same pattern
# `g +aliases add` uses.
#
# A candidate "identity" uniquely keys a destination across runs:
#   folder / alias  → "folder<TAB><abs path>"
#   worktree        → "worktree<TAB><abs path>"
#   branch          → "branch<TAB><repo toplevel><TAB><branch>"

# Print the identity of every entry in the history file, oldest first. Each
# history line is "<identity><TAB><epoch>", so the identity is the line with
# its trailing timestamp field removed.
__g_history_ids() {
  emulate -L zsh
  local hf="${XDG_DATA_HOME:-$HOME/.local/share}/g/history"
  [[ -f "$hf" ]] || return 0
  local line
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    print -r -- "${line%$'\t'*}"
  done < "$hf"
}

# Record a jump: move <identity> to the newest position. One line per identity
# (rewrite-to-dedupe), so the file stays small — one entry per distinct place
# you've ever jumped to — and its line order is exactly the recency order.
__g_history_record() {
  emulate -L zsh
  local id=$1
  local gdir="${XDG_DATA_HOME:-$HOME/.local/share}/g"
  local hf="$gdir/history"
  mkdir -p "$gdir"
  local tmp="$hf.tmp.$$"
  : > "$tmp"
  if [[ -f "$hf" ]]; then
    local line
    while IFS= read -r line; do
      [[ -z "$line" ]] && continue
      [[ "${line%$'\t'*}" == "$id" ]] && continue
      print -r -- "$line" >> "$tmp"
    done < "$hf"
  fi
  print -r -- "$id"$'\t'"${EPOCHSECONDS:-0}" >> "$tmp"
  mv "$tmp" "$hf"
}

# A canonical, order-independent signature of a candidate set: identities with
# their tabs encoded as '|', sorted, joined with ';'. Used as part of the
# decisions key so a remembered choice is invalidated the moment the set of
# things `g <name>` could mean changes.
__g_set_signature() {
  emulate -L zsh
  local -a ids
  local x
  for x in "$@"; do ids+=("${x//$'\t'/|}"); done
  ids=( "${(o)ids[@]}" )
  local IFS=';'
  print -r -- "${ids[*]}"
}

# Look up a remembered pick. Key: context dir + query + set signature. Prints
# the chosen identity (tabs encoded as '|') if one is stored, nothing if not.
__g_decision_lookup() {
  emulate -L zsh
  local dir=$1 query=$2 sig=$3
  local df="${XDG_DATA_HOME:-$HOME/.local/share}/g/decisions"
  [[ -f "$df" ]] || return 0
  local d_dir d_query d_sig d_choice
  while IFS=$'\t' read -r d_dir d_query d_sig d_choice; do
    if [[ "$d_dir" == "$dir" && "$d_query" == "$query" && "$d_sig" == "$sig" ]]; then
      print -r -- "$d_choice"
      return 0
    fi
  done < "$df"
  return 0
}

# Remember a pick, replacing any earlier decision with the same key.
__g_decision_record() {
  emulate -L zsh
  local dir=$1 query=$2 sig=$3 choice=$4
  local gdir="${XDG_DATA_HOME:-$HOME/.local/share}/g"
  local df="$gdir/decisions"
  mkdir -p "$gdir"
  local tmp="$df.tmp.$$"
  : > "$tmp"
  if [[ -f "$df" ]]; then
    local d_dir d_query d_sig d_choice
    while IFS=$'\t' read -r d_dir d_query d_sig d_choice; do
      [[ -z "$d_dir" ]] && continue
      [[ "$d_dir" == "$dir" && "$d_query" == "$query" && "$d_sig" == "$sig" ]] && continue
      printf '%s\t%s\t%s\t%s\n' "$d_dir" "$d_query" "$d_sig" "$d_choice" >> "$tmp"
    done < "$df"
  fi
  printf '%s\t%s\t%s\t%s\n' "$dir" "$query" "$sig" "$choice" >> "$tmp"
  mv "$tmp" "$df"
}

# Numbered chooser for an ambiguous `g <name>`. The menu is printed to stderr
# so stdout stays clean for the chosen index. Enter accepts option 1; 'q' or
# any out-of-range / non-numeric reply cancels. With no controlling tty it
# silently returns option 1, keeping `g` deterministic in scripts.
__g_pick() {
  emulate -L zsh
  local query=$1; shift
  local -a opts=( "$@" )
  local n=${#opts} i reply
  if [[ ! -t 0 || ! -t 2 ]]; then
    print -r -- 1
    return 0
  fi
  print -u2 ""
  print -u2 -r -- "g: '$query' is ambiguous —"
  for (( i = 1; i <= n; i++ )); do
    print -u2 -r -- "   $i) ${opts[i]}"
  done
  read -r "reply?  choose [1-$n] (enter = 1, q = cancel): "
  [[ -z "$reply" ]] && reply=1
  if [[ "$reply" == [qQ] || "$reply" != <-> ]] || (( reply < 1 || reply > n )); then
    print -u2 -r -- "g: cancelled"
    return 1
  fi
  print -r -- "$reply"
  return 0
}

g() {
  local debug=0
  if [[ "$1" == "--debug" ]]; then
    debug=1
    shift
  fi

  # `g -` — step back to where the last g move came from (this shell session).
  # Directory and worktree moves are always reversible. A branch move is only
  # reversed when it's safe — a plain `git switch` succeeds; if uncommitted
  # changes would clash, `g -` reports it and changes nothing (no timer: a
  # clean tree is fine to undo whether that was 10 seconds or an hour ago).
  if [[ "$1" == "-" ]]; then
    case "$_G_UNDO_KIND" in
      dir)
        if [[ ! -d "$_G_UNDO_DIR" ]]; then
          echo "g: previous directory no longer exists: $_G_UNDO_DIR" >&2
          return 1
        fi
        if (( debug )); then
          echo "g: would cd back to $_G_UNDO_DIR" >&2
          return 0
        fi
        echo "g: back to $_G_UNDO_DIR"
        __g_cd "$_G_UNDO_DIR"
        return
        ;;
      branch)
        local here
        here=$(git rev-parse --show-toplevel 2>/dev/null)
        if [[ "$here" != "$_G_UNDO_REPO" ]]; then
          echo "g: last branch change was in ${_G_UNDO_REPO:-another repo} — cd there to undo it" >&2
          return 1
        fi
        if (( debug )); then
          echo "g: would switch back to branch '$_G_UNDO_BRANCH'" >&2
          return 0
        fi
        __g_switch "$_G_UNDO_BRANCH" safe
        return
        ;;
      *)
        echo "g: nothing to undo in this session" >&2
        return 1
        ;;
    esac
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
    __g_cd "$root"
    return
  fi

  # ---- g <name>: smart resolver over aliases, folders, branches, worktrees ---
  # Match quality (exact > prefix > substring) decides the winner across all
  # kinds. A genuine tie goes to a learned decision if one exists, otherwise to
  # an interactive picker ordered by recency — and that pick is remembered.
  local name=$1
  local lname="${name:l}"

  # Repo context — branches and worktrees are only candidates inside a work
  # tree. repo_top doubles as the current worktree's root.
  local in_repo=0 repo_top=""
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    in_repo=1
    repo_top=$(git rev-parse --show-toplevel 2>/dev/null)
  fi

  # Worktree porcelain, gathered once: used both as candidates and to learn
  # which branches are already checked out somewhere.
  local -a wt_raw
  (( in_repo )) && wt_raw=( ${(f)"$(__g_worktrees)"} )

  # Candidates as parallel arrays — one slot per candidate. quality: 0 exact,
  # 1 prefix, 2 substring.
  local -a c_kind c_display c_target c_identity c_quality

  # aliases — exact (case-insensitive) name match only.
  if [[ -f "$aliases_file" ]]; then
    local a_name a_path
    while IFS=$'\t' read -r a_name a_path; do
      [[ -z "$a_name" ]] && continue
      if [[ "${a_name:l}" == "$lname" ]]; then
        a_path="${a_path:A}"
        c_kind+=(alias); c_target+=("$a_path"); c_identity+=("folder"$'\t'"$a_path")
        c_display+=("$a_name → ${a_path/#$HOME/~}"); c_quality+=(0)
      fi
    done < "$aliases_file"
  fi

  # folders under ~/Code and ~/Work, depth 1 and 2. exact > prefix > substring;
  # a depth-1 exact match may be any directory (preserving the old shortcut),
  # everything else must be a git repo. Each path is kept once, at best quality.
  local base fp fi
  local -a f_path f_qual
  for base in "$HOME/Code" "$HOME/Work"; do
    [[ -d "$base" ]] || continue
    for fp in "$base"/"$name"(N/);     do f_path+=("$fp"); f_qual+=(0); done
    for fp in "$base"/*/"$name"(N/);   do [[ -e "$fp/.git" ]] && { f_path+=("$fp"); f_qual+=(0); }; done
    for fp in "$base"/"$name"*(N/);    do [[ -e "$fp/.git" ]] && { f_path+=("$fp"); f_qual+=(1); }; done
    for fp in "$base"/*/"$name"*(N/);  do [[ -e "$fp/.git" ]] && { f_path+=("$fp"); f_qual+=(1); }; done
    for fp in "$base"/*"$name"*(N/);   do [[ -e "$fp/.git" ]] && { f_path+=("$fp"); f_qual+=(2); }; done
    for fp in "$base"/*/*"$name"*(N/); do [[ -e "$fp/.git" ]] && { f_path+=("$fp"); f_qual+=(2); }; done
  done
  local -A folder_seen
  for (( fi = 1; fi <= ${#f_path}; fi++ )); do
    fp="${f_path[fi]:A}"
    [[ -n "${folder_seen[$fp]}" ]] && continue
    folder_seen[$fp]=1
    c_kind+=(folder); c_target+=("$fp"); c_identity+=("folder"$'\t'"$fp")
    c_display+=("${fp/#$HOME/~}"); c_quality+=("${f_qual[fi]}")
  done

  # branches in the current repo (reflog-recent first, from __g_branches).
  if (( in_repo )); then
    local br brl bq
    for br in ${(f)"$(__g_branches)"}; do
      [[ -z "$br" ]] && continue
      brl="${br:l}"
      if   [[ "$brl" == "$lname"   ]]; then bq=0
      elif [[ "$brl" == "$lname"*  ]]; then bq=1
      elif [[ "$brl" == *"$lname"* ]]; then bq=2
      else continue
      fi
      c_kind+=(branch); c_target+=("$br"); c_identity+=("branch"$'\t'"$repo_top"$'\t'"$br")
      c_display+=("$br"); c_quality+=("$bq")
    done
  fi

  # worktrees in the current repo — matched on directory basename OR the branch
  # checked out there, whichever matches better.
  if (( in_repo )); then
    local wl wt_path wt_branch cand wq
    for wl in "${wt_raw[@]}"; do
      [[ -z "$wl" ]] && continue
      wt_path="${wl%%$'\t'*}"
      wt_branch="${wl#*$'\t'}"
      wq=3
      for cand in "${wt_path:t:l}" "${wt_branch:l}"; do
        [[ -z "$cand" ]] && continue
        if   [[ "$cand" == "$lname"   ]]; then (( wq > 0 )) && wq=0
        elif [[ "$cand" == "$lname"*  ]]; then (( wq > 1 )) && wq=1
        elif [[ "$cand" == *"$lname"* ]]; then (( wq > 2 )) && wq=2
        fi
      done
      (( wq == 3 )) && continue
      wt_path="${wt_path:A}"
      c_kind+=(worktree); c_target+=("$wt_path"); c_identity+=("worktree"$'\t'"$wt_path")
      c_display+=("${wt_path/#$HOME/~}${wt_branch:+  [$wt_branch]}"); c_quality+=("$wq")
    done
  fi

  # Branches checked out in some worktree — `git switch` to them fails, so they
  # collapse into their worktree candidate. This also drops the current branch
  # (the current worktree has it checked out).
  # (wl / wt_branch are already function-local from the worktree gather above;
  # re-declaring them with `local` would make zsh echo their values.)
  local -A wt_checked
  if (( in_repo )); then
    for wl in "${wt_raw[@]}"; do
      [[ -z "$wl" ]] && continue
      wt_branch="${wl#*$'\t'}"
      [[ -n "$wt_branch" ]] && wt_checked[$wt_branch]=1
    done
  fi

  # Filter into the kept set: drop no-op destinations (current worktree, $PWD)
  # and collapsed branches; dedupe folder/worktree clashes keeping the folder.
  local -a k_kind k_display k_target k_identity k_quality
  local -A path_seen
  local ci kk kt
  for (( ci = 1; ci <= ${#c_kind}; ci++ )); do
    kk="${c_kind[ci]}"; kt="${c_target[ci]}"
    case "$kk" in
      branch)
        [[ -n "${wt_checked[$kt]}" ]] && continue
        ;;
      worktree)
        [[ "$kt" -ef "$repo_top" ]] && continue
        [[ -n "${path_seen[$kt]}" ]] && continue
        path_seen[$kt]=1
        ;;
      folder|alias)
        [[ "$kt" -ef "$PWD" ]] && continue
        [[ -n "${path_seen[$kt]}" ]] && continue
        path_seen[$kt]=1
        ;;
    esac
    k_kind+=("$kk"); k_display+=("${c_display[ci]}"); k_target+=("$kt")
    k_identity+=("${c_identity[ci]}"); k_quality+=("${c_quality[ci]}")
  done

  if (( ${#k_kind} == 0 )); then
    if (( in_repo )); then
      print -u2 -r -- "g: nothing matching '$name' — no branch, worktree or folder (~/Code, ~/Work)"
    else
      print -u2 -r -- "g: nothing matching '$name' under ~/Code or ~/Work"
    fi
    return 1
  fi

  # Match quality decides: keep only the best-quality bucket as the tie set.
  local best_q=3 q
  for q in "${k_quality[@]}"; do (( q < best_q )) && best_q=$q; done
  local -a tie
  for (( ci = 1; ci <= ${#k_kind}; ci++ )); do
    [[ "${k_quality[ci]}" == "$best_q" ]] && tie+=("$ci")
  done

  # Recency ranks from the history file (later line = more recent).
  local -a _hids
  _hids=( ${(f)"$(__g_history_ids)"} )
  local -A hrank
  local hi
  for (( hi = 1; hi <= ${#_hids}; hi++ )); do
    [[ -n "${_hids[hi]}" ]] && hrank[${_hids[hi]}]=$hi
  done

  local winner_idx=0 decision_note="" remembered=0 sig=""

  if (( ${#tie} == 1 )); then
    winner_idx=${tie[1]}
    decision_note="single match"
  else
    # Ambiguous — consult the learned-decision cache first.
    local -a tie_ids
    for ci in "${tie[@]}"; do tie_ids+=("${k_identity[ci]}"); done
    sig=$(__g_set_signature "${tie_ids[@]}")
    local chosen
    chosen=$(__g_decision_lookup "${PWD:A}" "$lname" "$sig")
    if [[ -n "$chosen" ]]; then
      # Compare encoded-to-encoded: encoding a tab away is a glob-safe
      # substitution, whereas decoding '|' back to a tab is not (zsh reads a
      # bare '|' in a pattern as alternation).
      for ci in "${tie[@]}"; do
        if [[ "${k_identity[ci]//$'\t'/|}" == "$chosen" ]]; then
          winner_idx=$ci; remembered=1; break
        fi
      done
    fi
    if (( winner_idx )); then
      decision_note="remembered → ${k_display[winner_idx]}"
    else
      decision_note="would prompt — ${#tie} candidates tied"
    fi
  fi

  if (( debug )); then
    print -u2 -r -- "g: '$name' — ${#k_kind} candidate(s) after filtering"
    local qletter rk mk
    for (( ci = 1; ci <= ${#k_kind}; ci++ )); do
      case "${k_quality[ci]}" in
        0) qletter="exact " ;;
        1) qletter="prefix" ;;
        *) qletter="substr" ;;
      esac
      rk="${hrank[${k_identity[ci]}]:--}"
      mk=""
      (( ${tie[(Ie)$ci]} )) && mk="  [tie]"
      (( ci == winner_idx )) && mk="$mk  [winner]"
      printf '  %s  %-9s %-34s recency:%-3s%s\n' \
        "$qletter" "${k_kind[ci]}" "${k_display[ci]}" "$rk" "$mk" >&2
    done
    print -u2 -r -- "g: decision: $decision_note"
    if (( ${#tie} >= 2 )); then
      print -u2 -r -- "g: decision key: dir=${PWD:A}  query=$lname"
      print -u2 -r -- "g: decision sig: $sig"
    fi
    if (( winner_idx )); then
      if [[ "${k_kind[winner_idx]}" == branch ]]; then
        print -u2 -r -- "g: would switch to branch '${k_target[winner_idx]}'"
      else
        print -u2 -r -- "g: would cd to ${k_target[winner_idx]}"
      fi
    fi
    return 0
  fi

  if (( winner_idx == 0 )); then
    # No learned decision — order the tie set by recency (most recent first,
    # unseen last) and ask. The pick is remembered for this dir + query + set.
    local -a tie_seen tie_unseen tagged
    for ci in "${tie[@]}"; do
      if [[ -n "${hrank[${k_identity[ci]}]}" ]]; then
        tagged+=("${hrank[${k_identity[ci]}]} $ci")
      else
        tie_unseen+=("$ci")
      fi
    done
    tagged=( "${(@On)tagged}" )
    for ci in "${tagged[@]}"; do tie_seen+=("${ci##* }"); done
    local -a ordered
    ordered=( "${tie_seen[@]}" "${tie_unseen[@]}" )

    local -a pick_lines
    local oi line
    for (( oi = 1; oi <= ${#ordered}; oi++ )); do
      ci=${ordered[oi]}
      line=$(printf '%-9s %s' "${k_kind[ci]}" "${k_display[ci]}")
      (( oi == 1 && ${#tie_seen} > 0 )) && line="$line  (most recent)"
      pick_lines+=("$line")
    done

    local pick_n
    if pick_n=$(__g_pick "$name" "${pick_lines[@]}"); then
      winner_idx=${ordered[pick_n]}
    else
      return 1
    fi
    __g_decision_record "${PWD:A}" "$lname" "$sig" "${k_identity[winner_idx]//$'\t'/|}"
  fi

  (( remembered )) && print -u2 -r -- "g: → ${k_display[winner_idx]}  (remembered)"
  __g_history_record "${k_identity[winner_idx]}"
  if [[ "${k_kind[winner_idx]}" == branch ]]; then
    __g_switch "${k_target[winner_idx]}"
  else
    __g_cd "${k_target[winner_idx]}"
  fi
  return
}

_g() {
  local aliases_file="${XDG_DATA_HOME:-$HOME/.local/share}/g/aliases"
  local -a alias_list repo_list branch_list wt_list
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
      if git rev-parse --is-inside-work-tree &>/dev/null; then
        local bl wl wt_path wt_branch
        for bl in ${(f)"$(__g_branches)"}; do
          [[ -n "$bl" ]] && branch_list+=("$bl")
        done
        for wl in ${(f)"$(__g_worktrees)"}; do
          [[ -z "$wl" ]] && continue
          wt_path="${wl%%$'\t'*}"
          wt_branch="${wl#*$'\t'}"
          wt_list+=("${wt_path:t}")
          [[ -n "$wt_branch" ]] && wt_list+=("$wt_branch")
        done
        wt_list=(${(u)wt_list})
      fi
      # -V keeps each group in its given order (reflog recency for branches).
      _alternative \
        'aliases:alias:compadd -a alias_list' \
        'branches:branch:compadd -V g-branches -a branch_list' \
        'worktrees:worktree:compadd -a wt_list' \
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
