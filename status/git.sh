#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh

info "⚙️  ${TEXT_BOLD}Git status${TEXT_NORMAL}" Y
echo -e "This will check if all files can be located\nand if the symlinks are connected"

IGNOREGLOBAL_SRC="${DIR}/dotfiles/git/.gitignore_global"
IGNOREGLOBAL_DEST="${HOME}/.gitignore_global"
CONFIG_SRC="${DIR}/dotfiles/git/.gitconfig"
CONFIG_DEST="${HOME}/.gitconfig"

find_file_location "$IGNOREGLOBAL_SRC" ".gitignore_global source"
find_file_location "$IGNOREGLOBAL_DEST" ".gitignore_global destionation"

find_file_location "$CONFIG_SRC" ".gitconfig source"
find_file_location "$CONFIG_DEST" ".gitconfig destionation"

symlink_location_matches "$IGNOREGLOBAL_DEST" "$IGNOREGLOBAL_SRC" 
symlink_location_matches "$CONFIG_DEST" "$CONFIG_SRC" 

complete_message Y
