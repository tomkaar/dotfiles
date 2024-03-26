# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See plugins installation here:
# zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
plugins=(git gitfast zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Prompt
source ~/.git-prompt.sh
precmd () { __prompt_command }
function __prompt_command() {
    local EXIT="$?" # This needs to be first
    PS1=""

    local NORMAL="%{$FG[015]%}"
    local RED="%{$FG[009]%}"

    local stamp=$(date +%H:%M:%S)

    if [ $EXIT != 0 ]; then
        PS1+="${RED}${stamp}"
    else
        PS1+="${NORMAL}${stamp}"
    fi

    PS1+="${NORMAL} $(__git_ps1 "[%s] ")\$ "
}

# Git prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto verbose"
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWSTASHSTATE=1

#shell
SAVEHIST=100000
PS2="> "

# aliases
alias ll='ls -lia'

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

