# Path to your oh-my-zsh installation.
export ZSH="/Users/tommykarnstrom/.oh-my-zsh"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git gitfast zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Source the .iterm2_shell_integration.zsh if it exists
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Prompt
precmd () { __prompt_command }
function __prompt_command() {
    local EXIT="$?"             # This needs to be first
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

# Shell
SAVEHIST=100000
export EDITOR=/usr/local/bin/nano
PS2="> "

#aliases
alias typora='open -a typora'
alias ll='ls -lia'
