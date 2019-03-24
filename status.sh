#!/usr/bin/env bash
set -e

clear

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/src/utils.sh

info "⚙️  ${TEXT_BOLD}Status checks${TEXT_NORMAL}" Y

CHOICE_bash="${TPUT_BOLD}Bash ${TPUT_NORMAL} .bashrc and .bash_profile"
CHOICE_brew="${TPUT_BOLD}Brew ${TPUT_NORMAL} install formulas"
CHOICE_cask="${TPUT_BOLD}Cask ${TPUT_NORMAL} install casks"
CHOICE_ssh="${TPUT_BOLD}SSH ${TPUT_NORMAL} basic config file setup"
CHOICE_git="${TPUT_BOLD}Git ${TPUT_NORMAL} .gitconfig and .gitignore_global"
CHOICE_iterm2="${TPUT_BOLD}iTerm2 ${TPUT_NORMAL} Load preferences"
CHOICE_vscode="${TPUT_BOLD}Visual Studio Code ${TPUT_NORMAL} installation and extensions"
CHOICE_osx="${TPUT_BOLD}OSX ${TPUT_NORMAL} computer settings"

CHOICE_backtooptions="Back to options"
CHOICE_quit="${TPUT_BOLD}${TPUT_RED}Quit${TPUT_NORMAL}"

options=( "$CHOICE_bash" "$CHOICE_brew" "$CHOICE_cask" "$CHOICE_ssh" "$CHOICE_git"  "$CHOICE_vscode" "$CHOICE_iterm2" "$CHOICE_osx" "${CHOICE_backtooptions}" "$CHOICE_quit")
COLUMNS=1

PS3=$'\n'"Please enter your choice: "
select opt in "${options[@]}"
do  
    case $opt in
        "$CHOICE_bash")
            clear; "${DIR}/src/bash/status.sh" $DIR; break;
        ;;
        "$CHOICE_brew")
            clear; "${DIR}/src/brew/status.sh" $DIR; break;
        ;;
        "$CHOICE_cask")
            clear; "${DIR}/src/cask/status.sh" $DIR; break;
        ;;
        "$CHOICE_git")
            clear; "${DIR}/src/git/status.sh" $DIR; break;
        ;;
        "$CHOICE_ssh")
            clear; "${DIR}/src/ssh/status.sh" $DIR; break;
	    ;;
        "$CHOICE_iterm2")
            clear; "${DIR}/src/iterm2/status.sh" $DIR; break;
        ;;
        "$CHOICE_vscode")
            clear; "${DIR}/src/vscode/status.sh" $DIR; break;
        ;;
        "$CHOICE_osx")
            clear; "${DIR}/src/osx/status.sh" $DIR; break;
        ;;
        "${CHOICE_backtooptions}")
            clear; "${DIR}/start.sh"; break;
        ;;
        "$CHOICE_quit")
            abort_message Y; exit;
        ;;
        *) echo "invalid option $REPLY";;
    esac
done
