#!/usr/bin/env bash
set -e

clear

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/utils/utils.sh

info "🛠  ${TEXT_BOLD}Setup!${TEXT_NORMAL}" Y

CHOICE_bash="${TPUT_BOLD}Bash ${TPUT_NORMAL} .bashrc and .bash_profile"
CHOICE_brew="${TPUT_BOLD}Brew ${TPUT_NORMAL} install formulas"
CHOICE_cask="${TPUT_BOLD}Cask ${TPUT_NORMAL} install casks"
CHOICE_ssh="${TPUT_BOLD}SSH ${TPUT_NORMAL} basic config file setup"
CHOICE_git="${TPUT_BOLD}Git ${TPUT_NORMAL} .gitconfig and .gitignore_global"
CHOICE_vscode="${TPUT_BOLD}Visual Studio Code ${TPUT_NORMAL} installation and extensions"
CHOICE_osx="${TPUT_BOLD}OSX ${TPUT_NORMAL} computer settings OSX"

CHOICE_all="${TPUT_BOLD}${TPUT_YELLOW}Everything ${TPUT_NORMAL} "
CHOICE_quit="${TPUT_BOLD}${TPUT_RED}Quit ${TPUT_NORMAL} "

options=( "$CHOICE_bash" "$CHOICE_brew" "$CHOICE_cask" "$CHOICE_ssh" "$CHOICE_git" "$CHOICE_vscode" "$CHOICE_osx" "$CHOICE_all" "$CHOICE_quit")
COLUMNS=1

PS3=$'\n'"Please enter your choice: "
select opt in "${options[@]}"
do  
    case $opt in
        "$CHOICE_bash")
            clear; "${DIR}/setup/bash.sh" $DIR; break;
        ;;
        "$CHOICE_brew")
            clear; "${DIR}/setup/brew.sh" $DIR; break;
        ;;
        "$CHOICE_cask")
            clear; "${DIR}/setup/cask.sh" $DIR; break;
        ;;
        "$CHOICE_git")
            clear; "${DIR}/setup/git.sh" $DIR; break;
        ;;
        "$CHOICE_ssh")
            clear; "${DIR}/setup/ssh.sh" $DIR; break;
	    ;;
        "$CHOICE_vscode")
            clear; "${DIR}/setup/vscode.sh" $DIR; break;
        ;;
        "$CHOICE_osx")
            clear; "${DIR}/dotfiles/.osx" $DIR; break;
	    ;;
        "$CHOICE_all")
            clear;
            "${DIR}/setup/bash.sh" $DIR;
            "${DIR}/setup/brew.sh" $DIR;
            "${DIR}/setup/cask.sh" $DIR;
            "${DIR}/setup/ssh.sh" $DIR;
            "${DIR}/setup/git.sh" $DIR;
            "${DIR}/setup/vscode.sh" $DIR;
            "${DIR}/dotfiles/.osx"; 
            break;
	    ;;
        "$CHOICE_quit")
            abort_message Y; exit;
        ;;
        *) echo "invalid option $REPLY";;
    esac
done
