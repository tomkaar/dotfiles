#!/usr/bin/env bash
set -e

CURRENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $CURRENT_DIR/utils/utils.sh

info "🤔 What do you want to do?" Y

CHOICES_1="Setup"
CHOICES_2="Status check"
CHOICES_QUIT="${TPUT_RED}Quit${TPUT_NORMAL}"

PS3='Please enter your choice: '
options=("$CHOICES_1" "$CHOICES_2" "$CHOICES_QUIT")
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
