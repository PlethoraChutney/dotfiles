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

[ -f ~/.$(hostname)zc ] && source ~/.$(hostname)zc

if which gls>/dev/null
then
	alias ls="gls -F --color=auto"
else
	alias ls="ls -F --color=auto"
fi

alias la="ls -a"
alias ll="ls -alh"
alias grep="grep --color=auto"
export LS_COLORS="$LS_COLORS:ow=1;34;107:tw=1;34;107"

# ==========
# Automated stuff
# ==========
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rposert/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/rposert/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/rposert/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rposert/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
