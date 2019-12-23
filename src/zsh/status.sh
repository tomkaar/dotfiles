DIR="$1"
source $DIR/src/utils.sh

info "️️⚙️  ${TEXT_BOLD}Oh-my-zsh status${TEXT_NORMAL}" Y
echo "This will check if all files can be located\nand if the symlinks are connected"

RC_SRC="${DIR}/dotfiles/zsh/.zshrc"
RC_DEST="${HOME}/.zshrc"

find_file_location_only_visual "$RC_SRC" ".zshrc source"
find_file_location_only_visual "$RC_DEST" ".zshrc destination"

symlink_location_matches "$RC_DEST" "$RC_SRC" 

complete_message Y

backToStatusScreenOption
