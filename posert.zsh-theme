# entirely stolen from Britt Gresham
#
# prompt style and colors based on Steve Losh's Prose theme:
# http://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt

setopt prompt_subst
autoload colors
colors

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

autoload -U add-zsh-hook
autoload -Uz vcs_info

eval PR_BOLD="%{$terminfo[bold]%}"
#use extended color pallete if available
if [[ $TERM = *256color* || $TERM = *rxvt*  || $TERM = xterm-ghostty ]]; then
    MAGENTA="%F{magenta}"
    ORANGE="%F{yellow}"
    GREEN="%F{green}"
    PURPLE="%F{magenta}"
    BLUE="%F{blue}"
    WHITE="%F{white}"
    TEXT="%F{grey}"
    GREY="%F{grey}"
    RED="%F{red}"

    turquoise="%F{cyan}"
    darkorange="%F{yellow}"
    purple="%F{blue}"
    hotpink="%F{magenta}"
    limegreen="%F{green}"
else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    BLUE=$(tput setaf 4)
    WHITE=$(tput setaf 7)
    GREY=$(tput setaf 7)
    RED="%fg[red]"

    turquoise="$fg[cyan]"
    darkorange="$fg[yellow]"
    purple="$fg[magenta]"
    hotpink="$fg[red]"
    limegreen="$fg[green]"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

function virtualenv_info {
    [ $CONDA_DEFAULT_ENV ] && [ $CONDA_DEFAULT_ENV != base ] && echo '('$fg[blue]`basename $CONDA_DEFAULT_ENV`%{$GREY%}') '
}
PR_GIT_UPDATE=1

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%{${reset_color}%}"
FMT_BRANCH="(%{$PURPLE%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$GREEN%}%a${PR_RST})"
FMT_UNSTAGED="%{$darkorange%} ●${PR_RST}"
FMT_STAGED="%{$turquoise%} ●${PR_RST}"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_preexec {
    case "$(history $HISTCMD)" in
        *git*|*gs*|*ga*|*gc*|*gp*|*gl*|*gd*|*gf*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function _current_time {
  date +"%T"
}

function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="%{$GREY%}on %{$PURPLE%}%b%u%c%{$RED%} ●${PR_RST}"
        else
            FMT_BRANCH="%{$GREY%}on %{$PURPLE%}%b%u%c${PR_RST}"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

function _cmd_timer_start() {
  _timer=${_timer:-$SECONDS}
}
function _cmd_timer_end() {
  _timer=${_timer:-$SECONDS}
  _last_cmd_time=$(($SECONDS - $_timer))
  unset _timer
}
add-zsh-hook preexec _cmd_timer_start

function prompt-length() {
  emulate -L zsh
  local -i COLUMNS=${2:-COLUMNS}
  local -i x y=${#1} m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ))
    done
    while (( y > x + 1 )); do
      (( m = x + (y - x) / 2 ))
      (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
    done
  fi
  typeset -g REPLY=$x
}

# Usage: fill-line LEFT RIGHT
#
# Sets REPLY to LEFT<spaces>RIGHT with enough spaces in
# the middle to fill a terminal line.
function fill-line() {
  emulate -L zsh
  prompt-length $1
  local -i left_len=REPLY
  prompt-length $2 9999
  local -i right_len=REPLY
  local filler=${3:- }
  local fill_fmt=${4:- }
  local -i pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1} + 3))
  if (( pad_len < 1 )); then
    # Not enough space for the right part. Drop it.
    typeset -g REPLY=$1
  else
    local pad=${(pl.$pad_len..$filler.)}  # pad_len spaces
    typeset -g REPLY="${1} ${fill_fmt}${pad}%{$GREY%} ${2}"
  fi
}

_fmt_duration() {
  in=$1
  msg=""
  if [ $1 -gt 3600 ]; then
    hr=$(( in / 60 / 60 ))
    remain=$(( in - (hr * 60 * 60) ))
    msg+="${hr}h$(_fmt_duration $remain)"
  elif [ $1 -gt 60 ]; then
    min=$(( in / 60 ))
    remain=$(( in - (min * 60) ))
    msg+="${min}m$(_fmt_duration $remain)"
  elif [ $1 -gt 0 ]; then
    msg+="${1}s"
  fi
  echo $msg
}

# Sets PROMPT and RPROMPT.
#
# Requires: prompt_percent and no_prompt_subst.
function set-prompt() {
  exit_code="$?"
  _cmd_timer_end
  emulate -L zsh
  local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  git_branch=${git_branch//\%/%%}  # escape '%'

  exit_msg=""
  fill=" "
  if (( exit_code > 0 )); then
    exit_fmt="%{$RED%}"
    exit_msg="${exit_fmt}Exit code: ${exit_code}${GREY} | "
    fill="="
  fi

  timer_msg=""
  if (( _last_cmd_time > 0 )); then
    timer_msg="$(_fmt_duration ${_last_cmd_time}) | "
  fi

  local top_left="%B${MAGENTA}%n${GREY}%b at %B${ORANGE}%m${GREY}%b in %B${BLUE}%~${GREY}%b ${vcs_info_msg_0_}$(virtualenv_info)"
  local top_right="${GREY}[ ${exit_msg}${timer_msg}!%h ${GREY}]${reset_color}"
  local bottom_left="%{$GREY%}\$%{$reset_color%} ${TEXT}"
  local bottom_right="%{$BLUE%}$(_current_time)%{$reset_color%}"

  local REPLY
  fill-line "$top_left" "$top_right" "$fill" "$exit_fmt"
  PROMPT=$REPLY$'\n'$bottom_left
  RPROMPT=$bottom_right
}

setopt no_prompt_{bang,subst} prompt_{cr,percent,sp}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
