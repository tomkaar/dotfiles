#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/bash.sh

info "🛠  Bash setup (.bashrc and .bash_profile)" A

RC_SRC="${DIR}/dotfiles/bash/.bashrc"
RC_DEST="${HOME}/.bashrc"
PROFILE_SRC="${DIR}/dotfiles/bash/.bash_profile"
PROFILE_DEST="${HOME}/.bash_profile"

if find_file_location "$RC_SRC" ".bashrc"; then
    createLink "$RC_SRC" "$RC_DEST"
    symlink_location_matches "$RC_DEST" "$RC_SRC" 
fi

if find_file_location "$PROFILE_SRC" ".bash_profile"; then
    createLink "$PROFILE_SRC" "$PROFILE_DEST"
    symlink_location_matches "$PROFILE_DEST" "$PROFILE_SRC" 
fi

complete_message Y

backToSetupScreenOption
