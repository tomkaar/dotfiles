export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion



export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local NORMAL='\[\e[0m\]'
    local RED='\[\e[0;31m\]'

    local stamp=$(date +%H:%M:%S)

    if [ $EXIT != 0 ]; then
        PS1+="${RED}${stamp}"
    else
        PS1+="${NORMAL}${stamp}"
    fi

    echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"

    PS1+="${NORMAL} $(__git_ps1 "[%s] ")\$ "
}

# Git prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto verbose"
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWSTASHSTATE=1

# bash
shopt -s histappend
export HISTCONTROL=ignoredups:erasedups:ignorespace # history control
export HISTSIZE=100000 # history size
export HISTFILESIZE=100000 # history file size
export EDITOR=/usr/local/bin/nano 
export LC_ALL="en_US.UTF-8"
export LANG="en_US:en"
PS2="> "

#aliases
alias typora='open -a typora'
