#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/src/utils.sh

info "⚙️  ${TEXT_BOLD}SSH status${TEXT_NORMAL}" Y
echo -e "This will check if all files can be located\nand if the symlinks are connected"

SSH_SRC="${DIR}/dotfiles/ssh/config"
SSH_DEST="${HOME}/.ssh/config"

find_file_location_only_visual "$SSH_SRC" ".ssh/config source"
find_file_location_only_visual "$SSH_DEST" ".ssh/config destionation"
symlink_location_matches "$SSH_DEST" "$SSH_SRC" 

complete_message Y

backToStatusScreenOption
