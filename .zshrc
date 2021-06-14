# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt CORRECT_ALL

setopt nomatch
setopt AUTO_CD
unsetopt autocd beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/local/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# Case insensitive globbing
unsetopt CASE_GLOB
#
# Don't fully expand globs in commands
setopt GLOB_COMPLETE
#
# Offer corrections for typos
setopt CORRECT_ALL
#
# common aliases
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -AlFh'

alias grep='grep --color=auto'

# directory traversal
cds () {
        SCRATCHNAME=$(echo $HOST | sed "s/\..*//")

        if [ $# -eq 0 ]
                then
                        cd /$SCRATCHNAME/scratch/$USER/
                else
                        cd /$SCRATCHNAME/scratch/$USER/${1}*
        fi
}

alias cdt="cds"

cdgr () {
        if [ $# -eq 0 ]
                then
                        cd /goliath/rawdata/BaconguisLab/$USER/
                else
                        cd /goliath/rawdata/BaconguisLab/$USER/${1}*
        fi
}
alias cdg='cdgr'
cdgp () {
        if [ $# -eq 0 ]
                then
                        cd /goliath/processing/BaconguisLab/$USER/
                else
                        cd /goliath/processing/BaconguisLab/$USER/${1}*
        fi
}


# prompt
PROMPT='%F{186}%n%f @ %F{214}%m%f %F{33}%~%f'$'\n''%# '

# include
include () {
	[[ -f ${1} ]] && source ${1}
}


# remote logins
alias troll="ssh -Y posert@troll.ohsu.edu"
alias hotspur="ssh -X posert@hotspur.ohsu.edu"
alias falstaff="ssh -X posert@falstaff.ohsu.edu"
alias hen4="ssh -X posert@henry4.ohsu.edu"
alias hen5="ssh -X posert@henry5.ohsu.edu"
alias juliet="ssh -X posert@juliet.ohsu.edu"
alias exahead="ssh -X posert@exahead1.ohsu.edu"
alias cascade="ssh -X pose732@cascade.emsl.pnl.gov"
alias vcascade="ssh -vX pose732@cascade.emsl.pnl.gov"
alias askel="ssh -Y posert@10.137.46.15"
alias laskel='ssh -Y local@10.137.46.15'
alias exa1="ssh -Y posert@exahead1.ohsu.edu"
alias exa2="ssh -Y posert@exahead2.ohsu.edu"
alias exacloud='exa1'

