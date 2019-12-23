DIR="$1"
source $DIR/src/utils.sh

info "🛠  Oh-my-zsh setup (.bashrc and .bash_profile)" A

RC_SRC="${DIR}/dotfiles/zsh/.zshrc"
RC_DEST="${HOME}/.zshrc"

if find_file_location "$RC_SRC" ".zshrc"; then
    createLink "$RC_SRC" "$RC_DEST"
    symlink_location_matches "$RC_DEST" "$RC_SRC" 
fi

complete_message Y

backToSetupScreenOption
