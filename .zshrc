[ -f ~/.hostzc ] && source ~/.hostzc
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="posert"
export BAT_THEME="Solarized (dark)"

plugins=(git colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration ====================================

cds () {
    if [ $# -eq 0 ]; then
        cd ~/Documents/scripts
    else
        cd ~/Documents/scripts/$1*
    fi
}
cdd () {
    if [ $# -eq 0 ]; then
        cd ~/Documents
    else
        cd ~/Documents/$1*
    fi
}


export PATH="$PATH:$HOME/.scripts:$HOME/.local/bin"

if (( $+commands[nvim] )); then
	alias vim=nvim
fi

export EDITOR=vim
export SUDO_EDITOR=vim

strlen() {
	echo -n $1 | wc -c
}


if which gls>/dev/null
then
	alias ls="gls --color=auto"
else
	alias ls="ls --color=auto"
fi

alias la="ls -a"
alias ll="ls -alh"
alias grep="grep --color=auto"

make_gif () {
	ffmpeg -i $1 -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse,fps=50" $2
}
