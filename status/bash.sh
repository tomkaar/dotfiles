#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/bash.sh

info "️️⚙️  ${TEXT_BOLD}Bash status${TEXT_NORMAL}" Y
echo -e "This will check if all files can be located\nand if the symlinks are connected"

RC_SRC="${DIR}/dotfiles/bash/.bashrc"
RC_DEST="${HOME}/.bashrc"
PROFILE_SRC="${DIR}/dotfiles/bash/.bash_profile"
PROFILE_DEST="${HOME}/.bash_profile"

find_file_location_only_visual "$RC_SRC" ".bashrc source"
find_file_location_only_visual "$RC_DEST" ".bashrc destionation"

find_file_location_only_visual "$PROFILE_SRC" ".bash_profile source"
find_file_location_only_visual "$PROFILE_DEST" ".bash_profile destionation"

symlink_location_matches "$RC_DEST" "$RC_SRC" 
symlink_location_matches "$PROFILE_DEST" "$PROFILE_SRC" 

complete_message Y
