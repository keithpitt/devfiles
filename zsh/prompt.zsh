autoload -U colors
colors
setopt prompt_subst

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

# Customizable parameters.
PROMPT_DEFAULT_END=❯
PROMPT_ROOT_END=❯❯❯
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]
PROMPT_GIT_REPO_COLOR=$FG[039]
PROMPT_GIT_PATH_COLOR=$FG[067]
PROMPT_GIT_REPO_ICON=$'\uF1D2'  # nf-fa-git_alt
PROMPT_GITHUB_REPO_ICON=$''  # nf-fa-github
PROMPT_GIT_BRANCH_ICON=$'\uE726'  # nf-dev-git_branch

# Set required options.
setopt promptsubst

# Load required modules.
autoload -Uz vcs_info

precmd() {
  vcs_info
  echo -ne "\e]1;$(basename `pwd`)\a"

  local git_root
  git_root=$(command git rev-parse --show-toplevel 2>/dev/null)

  if [[ -n "$git_root" ]]; then
    local git_remote_url org_name="" host=""
    git_remote_url=$(command git config --get remote.origin.url 2>/dev/null)
    if [[ -n "$git_remote_url" ]]; then
      local url_no_git="${git_remote_url%.git}"
      local before_repo="${url_no_git%/*}"
      org_name="${before_repo##*[:/]}"

      local host_part="${url_no_git#*://}"
      host_part="${host_part#*@}"
      host="${host_part%%[:/]*}"
      if [[ -n "$host" && "$host" != "github.com" ]]; then
        org_name="${host}/${org_name}"
      fi
    fi

    local repo_icon="$PROMPT_GIT_REPO_ICON"
    [[ "$host" == "github.com" ]] && repo_icon="$PROMPT_GITHUB_REPO_ICON"

    local repo_label="${git_root:t}"
    [[ -n "$org_name" ]] && repo_label="${org_name}/${repo_label}"

    local rel_path="${PWD#$git_root}"
    rel_path="${rel_path#/}"

    PROMPT_LOCATION="%{$PROMPT_GIT_REPO_COLOR%}${repo_icon} ${repo_label}"
    [[ -n "$rel_path" ]] && PROMPT_LOCATION+="%{$FX[no-bold]%}%{$PROMPT_GIT_PATH_COLOR%}/${rel_path}"
    PROMPT_LOCATION+="%{$FX[reset]%}"
    if [[ -f "$git_root/.zshprompt" ]]; then
      PROMPT_PREFIX="$(<"$git_root/.zshprompt")"
    else
      PROMPT_PREFIX=""
    fi

    # Branch color: gray (clean) / red (unstaged or untracked) / green (only staged).
    PROMPT_BRANCH_COLOR="$PROMPT_VCS_INFO_COLOR"
    local porcelain
    porcelain=$(command git status --porcelain 2>/dev/null)
    if [[ -n "$porcelain" ]]; then
      local line has_unstaged=0 has_staged=0
      for line in ${(f)porcelain}; do
        [[ "${line[2]}" != " " ]] && has_unstaged=1
        [[ "${line[1]}" != " " && "${line[1]}" != "?" ]] && has_staged=1
      done
      if (( has_unstaged )); then
        PROMPT_BRANCH_COLOR="$PROMPT_FAILURE_COLOR"
      elif (( has_staged )); then
        PROMPT_BRANCH_COLOR="$PROMPT_SUCCESS_COLOR"
      fi
    fi
  else
    PROMPT_LOCATION="%{$FG[242]%}%~%{$FX[reset]%}"
    PROMPT_PREFIX=""
    PROMPT_BRANCH_COLOR="$PROMPT_VCS_INFO_COLOR"
  fi
}

# Set vcs_info parameters: only branch info is shown (on the right).
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes false # Can be slow on big repos if set to true.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "" "${PROMPT_GIT_BRANCH_ICON} %b (%a)"
zstyle ':vcs_info:*:*' formats "" "${PROMPT_GIT_BRANCH_ICON} %b"
zstyle ':vcs_info:*:*' nvcsformats "" ""

# Define prompts.
PROMPT='${PROMPT_PREFIX:+${PROMPT_PREFIX} }'"${SSH_TTY:+[%n@%m] }"'${PROMPT_LOCATION}'" %(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[reset]%} "
RPROMPT='${PROMPT_BRANCH_COLOR}${vcs_info_msg_1_}'"%{$FX[reset]%}"
