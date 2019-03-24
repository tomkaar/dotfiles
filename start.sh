#!/usr/bin/env bash
set -e

clear

CURRENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $CURRENT_DIR/src/utils.sh

info "${TEXT_BOLD}🤔 What do you want to do?${TEXT_NORMAL}" Y

CHOICES_1="${TPUT_BOLD}Setup ${TPUT_NORMAL} Install and set up enviornment, programs and more"
CHOICES_2="${TPUT_BOLD}Status ${TPUT_NORMAL} Check installations and connections"
CHOICES_QUIT="${TPUT_BOLD}${TPUT_RED}Quit${TPUT_NORMAL}"

PS3=$'\n'"Please enter your choice: "
options=("$CHOICES_1" "$CHOICES_2" "$CHOICES_QUIT")
COLUMNS=1
select opt in "${options[@]}"
do
    case $opt in
        "$CHOICES_1")
            "${CURRENT_DIR}/setup.sh"; break;
        ;;
        "$CHOICES_2")
            "${CURRENT_DIR}/status.sh"; break;
        ;;
        "$CHOICES_QUIT")
            abort_message Y; exit;
        ;;
        *) echo "invalid option $REPLY";
    esac
done
