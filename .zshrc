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

[ -f ~/.hostzc ] && source ~/.hostzc

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$PATH:$HOME/.scripts"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

if (( $+commands[nvim] )); then
	alias vim=$(which nvim)
fi

export EDITOR="$(which vim)"

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
