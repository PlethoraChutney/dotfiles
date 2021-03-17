# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

include () {
    [[ -f ${1} ]] && source ${1}
}

# preferred prompt and grep
RCol='\[\e[0m\]'

Red='\[\e[0;31m\]'
Gre='\[\e[0;32m\]'
BYel='\[\e[1;33m\]'
BBlu='\[\e[1;34m\]'
Pur='\[\e[0;35m\]'

PS1="${Gre}\u ${RCol}@ ${BYel}\h ${BBlu}\w ${RCol}\n$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Unlimited history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# exacloud logins
alias troll="ssh -Y posert@troll.ohsu.edu"
alias hotspur="ssh -X posert@hotspur.ohsu.edu"
alias falstaff="ssh -X posert@falstaff.ohsu.edu"
alias hen4="ssh -X posert@henry4.ohsu.edu"
alias hen5="ssh -X posert@henry5.ohsu.edu"
alias juliet="ssh -X posert@juliet.ohsu.edu"
alias exahead="ssh -X posert@exahead1.ohsu.edu"
alias cascade="ssh -X pose732@cascade.emsl.pnl.gov"
alias vcascade="ssh -vX pose732@cascade.emsl.pnl.gov"
alias askel="ssh -Y posert@askeladden.ohsu.edu"

# wsl display
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1

# has to be different if connected over OHSU VPN
alias vpndisp="DISPLAY=$(ip addr show eth2 | grep inet\ | awk '{gsub("/.*", "", $2)}; {print $2}'):0"

# coloration and ls aliases
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -Falh"
alias grep="grep --color=auto"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
