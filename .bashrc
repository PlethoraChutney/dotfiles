# .bashrc
# User specific aliases and functions
# Make it easier to read PATH variables
sepcol () {
	sed 's/:/\n/g' <<< ${1}
}

# CryoEM Setup
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
alias troll="ssh -X posert@troll.ohsu.edu"
alias hotspur="ssh -X posert@hotspur.ohsu.edu"
alias falstaff="ssh -X posert@falstaff.ohsu.edu"
alias hen4="ssh -X posert@henry4.ohsu.edu"
alias hen5="ssh -X posert@henry5.ohsu.edu"
alias juliet="ssh -x posert@juliet.ohsu.edu"
alias exahead="ssh -X posert@exahead1.ohsu.edu"
alias cascade="ssh -X pose732@cascade.emsl.pnl.gov"
alias vcascade="ssh -vX pose732@cascade.emsl.pnl.gov"
export DISPLAY=127.0.0.1:0

# coloration and ls aliases
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -la"
export GREP_OPTIONS='--color=auto'

# traversal aliases
export EXPERIMENTS_DIR="/mnt/d/Rich/Documents/Experiments/"
export SCRIPTS_DIR="/mnt/d/Rich/Documents/Scripts"
exp() {
    cd $EXPERIMENTS_DIR/$(ls $EXPERIMENTS_DIR | grep $1)
}


