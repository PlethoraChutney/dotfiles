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
bindkey '^R' history-incremental-search-backward
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/posert/.zshrc'

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

include () {
  [[ -f ${1} ]] && source ${1}
}

# directory traversal

# prompt
PROMPT='%F{186}%n%f @ %F{214}%m%f %F{33}%~%f'$'\n''%# '

# ssh commands
alias troll="ssh -Y posert@troll.ohsu.edu"
alias hotspur="ssh -X posert@hotspur.ohsu.edu"
alias falstaff="ssh -X posert@falstaff.ohsu.edu"
alias hen4="ssh -X posert@henry4.ohsu.edu"
alias hen5="ssh -X posert@henry5.ohsu.edu"
alias juliet="ssh -X posert@juliet.ohsu.edu"
alias exahead="ssh -X posert@exahead1.ohsu.edu"
alias boreal="ssh -X pose732@boreal.emsl.pnl.gov"
alias askel="ssh -Y posert@askeladden.ohsu.edu"
alias laskel="ssh -Y local@askeladden.ohsu.edu"
alias exa1="ssh -Y posert@exahead1.ohsu.edu"
alias exa2="ssh -Y posert@exahead2.ohsu.edu"
alias exacloud='exa1'
alias raspi="ssh rich@192.168.0.202"

mcd () {
	mkdir $1 && cd $1
}

# scp aliases

getboreal () {
	scp pose732@boreal.emsl.pnl.gov:/dtemp/emslp160003/$1/\*/job$2 $3
}

putboreal () {
	scp $1 pose732@boreal.emsl.pnl.gov:/dtemp/emslp160003/$2
}

getrel () {
        scp posert@askeladden.ohsu.edu:/askeladden/scratch/posert/$1 $2
}

getex () {
    if [[ $2 = ref3d ]]
    then
        scp posert@exahead1.ohsu.edu:/home/exacloud/gscratch/BaconguisLab/posert/$1/Refine3D/job$3/run_class001.mrc ./$1_$3.mrc
    elif [[ $2 = mask ]]
    then
        scp posert@exahead1.ohsu.edu:/home/exacloud/gscratch/BaconguisLab/posert/$1/\*/job$3/mask.mrc ./$1_$3-mask.mrc
    elif [[ $2 = class3d ]]
    then
        mkdir $1_$3
        pushd $1_$3
        scp posert@exahead1.ohsu.edu:/home/exacloud/gscratch/BaconguisLab/posert/$1/\*/job$3/run_it025_class\*.mrc .
        popd
    else
        scp posert@exahead1.ohsu.edu:/home/exacloud/gscratch/BaconguisLab/posert/$1/\*/job$2 $3
    fi
}

putex () {
	scp $1 posert@exahead1.ohsu.edu:/home/exacloud/gscratch/BaconguisLab/posert/$2 
}

putask () {
        scp $1 posert@askeladden.ohsu.edu:/askeladden/scratch/posert/$2
}

getask () {
    if [[ $2 = ref3d ]]
    then
        scp posert@askeladden.ohsu.edu:/askeladden/scratch/posert/$1/Refine3D/job$3/run_class001.mrc ./$1_$3.mrc
    elif [[ $2 = mask ]]
    then
        scp posert@askeladden.ohsu.edu:/askeladden/scratch/posert/$1/\*/job$3/mask.mrc ./$1_$3-mask.mrc
    elif [[ $2 = class3d ]]
    then
        mkdir $1_$3
        pushd $1_$3
        scp posert@askeladden.ohsu.edu:/askeladden/scratch/posert/$1/\*/job$3/run_it025_class\*.mrc .
        popd
    else
        scp posert@askeladden.ohsu.edu:/askeladden/scratch/posert/$1/\*/job$2 $3
    fi
}

get_all_classes () {
	if [ -z "$2" ]
		then
			CRYOSPARC_PROCESSING="@goliath.ohsu.edu:/goliath/processing/BaconguisLab/$(whoami)/cryosparc"
    		else
      			CRYOSPARC_PROCESSING="@goliath.ohsu.edu:/goliath/processing/BaconguisLab/$2/cryosparc"
  	fi
  
	rsync -avzP $(whoami)$CRYOSPARC_PROCESSING/$1/\*volume.mrc ./
}

include ~/.$(hostname)zc

# exacloud download
getcis () {
        scp posert@exahead1.ohsu.edu:/home/groups/BaconguisLab/posert/$1/cistem-project/Assets/Volumes/$2 $3
}

# wsl display
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1

# has to be different if connected over OHSU VPN
vpndisp () {
        ip addr show eth2 &>/dev/null
        if [ $? -eq 0 ]; then
                DISPLAY=$(ip addr show eth2 | grep inet\ | awk '{gsub("/.*", "", $2)}; {print $2}'):0
        fi
}

# coloration and ls aliases
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -Falh"
alias grep="grep --color=auto"
export LS_COLORS="$LS_COLORS:ow=1;34;107:tw=1;34;107"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
