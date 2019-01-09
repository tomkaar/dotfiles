#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh

info "🛠  Git setup (.gitconfig and .gitignore_global)" A

IGNOREGLOBAL_SRC="${DIR}/dotfiles/git/.gitignore_global"
IGNOREGLOBAL_DEST="${HOME}/.gitignore_global"
CONFIG_SRC="${DIR}/dotfiles/git/.gitconfig"
CONFIG_DEST="${HOME}/.gitconfig"

if find_file_location "$IGNOREGLOBAL_SRC" ".gitignore_global"; then
    createLink "$IGNOREGLOBAL_SRC" "$IGNOREGLOBAL_DEST"
    symlink_location_matches "$IGNOREGLOBAL_DEST" "$IGNOREGLOBAL_SRC" 
fi

if find_file_location "$CONFIG_SRC" "..gitconfig"; then
    createLink "$CONFIG_SRC" "$CONFIG_DEST"
    symlink_location_matches "$CONFIG_DEST" "$CONFIG_SRC" 
fi

complete_message Y
