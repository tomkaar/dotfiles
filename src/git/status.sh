DIR="$1"
source $DIR/src/utils.sh

info "⚙️  ${TEXT_BOLD}Git status${TEXT_NORMAL}" Y
echo "This will check if all files can be located\nand if the symlinks are connected"

IGNOREGLOBAL_SRC="${DIR}/dotfiles/git/.gitignore_global"
IGNOREGLOBAL_DEST="${HOME}/.gitignore_global"
CONFIG_SRC="${DIR}/dotfiles/git/.gitconfig"
CONFIG_DEST="${HOME}/.gitconfig"

find_file_location_only_visual "$IGNOREGLOBAL_SRC" ".gitignore_global source"
find_file_location_only_visual "$IGNOREGLOBAL_DEST" ".gitignore_global destionation"

find_file_location_only_visual "$CONFIG_SRC" ".gitconfig source"
find_file_location_only_visual "$CONFIG_DEST" ".gitconfig destionation"

symlink_location_matches "$IGNOREGLOBAL_DEST" "$IGNOREGLOBAL_SRC" 
symlink_location_matches "$CONFIG_DEST" "$CONFIG_SRC" 

complete_message Y

backToStatusScreenOption
