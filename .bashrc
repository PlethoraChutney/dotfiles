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

##### OHSU Login and Navigation ######
# remote logins
alias troll="ssh -Y $(whoami)@troll.ohsu.edu"
alias hotspur="ssh -X $(whoami)@hotspur.ohsu.edu"
alias falstaff="ssh -X $(whoami)@falstaff.ohsu.edu"
alias hen4="ssh -X $(whoami)@henry4.ohsu.edu"
alias hen5="ssh -X $(whoami)@henry5.ohsu.edu"
alias juliet="ssh -X $(whoami)@juliet.ohsu.edu"
alias exahead="ssh -X $(whoami)@exahead1.ohsu.edu"
alias boreal="ssh -X pose732@boreal.emsl.pnl.gov"
alias askel="ssh -Y $(whoami)@askeladden.ohsu.edu"
alias exacloud="ssh -Y $(whoami)@exahead1.ohsu.edu"
alias exa1="ssh -Y $(whoami)@exahead1.ohsu.edu"
alias exa2="ssh -Y $(whoami)@exahead2.ohsu.edu"


# relion download

getboreal () {
	scp pose732@boreal.emsl.pnl.gov:$1 $2
}

getrel () {
	scp $(whoami)@10.137.46.15:/askeladden/scratch/$(whoami)/$1 $2
}

getex () {
	scp $(whoami)@exahead1.ohsu.edu:/home/exacloud/gscratch/BaconguisLab/$(whoami)/$1 $2
}

putrel () {
	scp $1 $(whoami)@10.137.46.15:/askeladden/scratch/$(whoami)/$2
}

putrel () {
	scp $1 $(whoami)@10.137.46.15:/askeladden/scratch/$(whoami)/$2
}

# exacloud download
getcis () {
	scp $(whoami)@exahead1.ohsu.edu:/home/exacloud/gscratch/BaconguisLab/$(whoami)/$1/cistem-project/Assets/Volumes/$2 $3
}

cds () {
  if [ $# -eq 0 ]
    then
      cd /$(hostname)/scratch/$(whoami)/
    else
      cd /$(hostname)/scratch/$(whoami)/${1}*
  fi
}

cdst () {
  if [ $# -eq 0 ]
    then
      cd /$(hostname)/scratch/$(whoami)/
    else
      cd /$(hostname)/scratch/$(whoami)/${1}*
  fi
}

cdgp () {
  if [ $# -eq 0 ]
    then
      cd /goliath/processing/BaconguisLab/$(whoami)/
    else
      cd /goliath/processing/BaconguisLab/$(whoami)/${1}*
  fi
}



cdgr () {
  if [ $# -eq 0 ]
    then
      cd /goliath/rawdata/BaconguisLab/$(whoami)/
    else
      cd /goliath/rawdata/BaconguisLab/$(whoami)/${1}*
  fi
}

get_all_classes () {
	if [ -z "$2" ]
		then
			CRYOSPARC_PROCESSING="@goliath.ohsu.edu:/goliath/processing/BaconguisLab/$(whoami)/cryosparc"
	else
		CRYOSPARC_PROCESSING="@goliath.ohsu.edu:/goliath/processing/BaconguisLab/$2/cryosparc"
	fi
	
	rsync -avzP "$(whoami)$CRYOSPARC_PROCESSING/$1/*volume.mrc" ./
}

###### Host-Specific ######
include ~/.$(hostname)rc

# coloration and ls aliases
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -Falh"
alias grep="grep --color=auto"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
