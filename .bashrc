# .bashrc
# User specific aliases and functions
## ls aliases
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lA'

alias grep="grep --color=auto"
alias troll='ssh -X posert@troll.ohsu.edu'
alias hotspur='ssh -X posert@hotspur.ohsu.edu'
alias falstaff='ssh -X posert@falstaff.ohsu.edu'
alias hen4='ssh -X posert@henry4.ohsu.edu'
alias hen5='ssh -X posert@henry5.ohsu.edu'

# preferred prompt and grep
RCol='\[\e[0m\]'

Red='\[\e[0;31m\]'
Gre='\[\e[0;32m\]'
BYel='\[\e[1;33m\]'
BBlu='\[\e[1;34m\]'
Pur='\[\e[0;35m\]'
    
PS1="\n${Gre}\u ${RCol}@ ${BYel}\h ${BBlu}\w ${RCol}$ "

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
