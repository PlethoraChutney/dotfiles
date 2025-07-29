[ -f ~/.hostzc ] && source ~/.hostzc
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="posert"
export ZSH_THEME
export BAT_THEME="Solarized (dark)"

plugins=(git colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration ====================================

export PATH="$PATH:$HOME/.scripts:$HOME/.local/bin:$HOME/.cargo/bin"

if (( $+commands[hx] )); then
	export EDITOR=hx
	SUDO_EDITOR=$(command -v hx)
elif (( $+commands[nvim] )); then
	alias vim=nvim
	export EDITOR=nvim
	SUDO_EDITOR=$(command -v nvim)
else
	export EDITOR=vim
	SUDO_EDITOR=vim
export SUDO_EDITOR

fi

strlen() {
	echo -n "$1" | wc -c
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
	ffmpeg -i "$1" -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse,fps=50" "$2"
}

