#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh

info "🛠  SSH setup" A

CONFIG_SRC="${DIR}/dotfiles/ssh/config"
CONFIG_DEST="${HOME}/.ssh/config"

if find_file_location "$CONFIG_SRC" ".ssh/config"; then
    createLink "$CONFIG_SRC" "$CONFIG_DEST"
    symlink_location_matches "$CONFIG_DEST" "$CONFIG_SRC" 
fi

complete_message Y
