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

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$PATH:$HOME/.scripts"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export EDITOR="$(which vim)"

[ -f ~/.hostzc ] && source ~/.hostzc

if which gls>/dev/null
then
	alias ls="gls --color=auto"
else
	alias ls="ls --color=auto"
fi

alias la="ls -a"
alias ll="ls -alh"
alias grep="grep --color=auto"
export LS_COLORS="$LS_COLORS:ow=1;101:tw=1;30;101:st=1;30;101"

make_gif () {
	ffmpeg -i $1 -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse,fps=50" $2
}

# ==========
# Automated stuff
# ==========
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=("$HOME/.juliaup/bin" $path)
export PATH

# <<< juliaup initialize <<<
