#!/usr/bin/env bash
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/utils/utils.sh

info "🛠  Setup!" Y

CHOICE_bash="Bash (.bashrc and .bash_profile)"
CHOICE_brew="Brew (install formulas)"
CHOICE_cask="Cask (install casks)"
CHOICE_ssh="SSH (basic config file setup)"
CHOICE_git="Git (.gitconfig and .gitignore_global)"
CHOICE_vscode="Visual Studio Code (installation and extensions)"
CHOICE_osx="OSX (computer settings)"

CHOICE_all="${TPUT_YELLOW}Everything${TPUT_NORMAL} (in order from top to bottom)"
CHOICE_quit="${TPUT_RED}Quit${TPUT_NORMAL}"

options=( "$CHOICE_bash" "$CHOICE_brew" "$CHOICE_cask" "$CHOICE_ssh" "$CHOICE_git" "$CHOICE_vscode" "$CHOICE_osx" "$CHOICE_all" "$CHOICE_quit")
COLUMNS=1

PS3="Please enter your choice: "
select opt in "${options[@]}"
do
    case $opt in
        "$CHOICE_bash")
            "${DIR}/setup/bash.sh" $DIR; break;
        ;;
        "$CHOICE_brew")
            "${DIR}/setup/brew.sh" $DIR; break;
        ;;
        "$CHOICE_cask")
            "${DIR}/setup/cask.sh" $DIR; break;
        ;;
        "$CHOICE_git")
            "${DIR}/setup/git.sh" $DIR; break;
        ;;
        "$CHOICE_ssh")
            "${DIR}/setup/ssh.sh" $DIR; break;
	    ;;
        "$CHOICE_vscode")
            "${DIR}/setup/vscode.sh" $DIR; break;
        ;;
        "$CHOICE_osx")
            "${DIR}/dotfiles/.osx" $DIR; break;
	    ;;
        "$CHOICE_all")
            "${DIR}/setup/bash.sh" $DIR;
            "${DIR}/setup/brew.sh" $DIR;
            "${DIR}/setup/cask.sh" $DIR;
            "${DIR}/setup/ssh.sh" $DIR;
            "${DIR}/setup/git.sh" $DIR;
            "${DIR}/setup/vscode.sh" $DIR;
            "${DIR}/dotfiles/.osx"; break;
	    ;;
        "$CHOICE_quit")
            abort_message Y; exit;
        ;;
        *) echo "invalid option $REPLY";;
    esac
done
