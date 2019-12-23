


DIR="$1"
source $DIR/src/utils.sh
source $DIR/src/vscode/utils.sh

info "🛠  Visual Studio Code setup" A

CONFIG_SRC="${DIR}/dotfiles/vscode/settings.json"
CONFIG_DEST="${HOME}/Library/Application Support/Code/User/settings.json"

install_vscode_prompt

vscode_install_extensions

text_space_above "Settings"
if find_file_location "$CONFIG_SRC" "vscode/settings"; then
    createLink "$CONFIG_SRC" "$CONFIG_DEST"
    symlink_location_matches "$CONFIG_DEST" "$CONFIG_SRC" 
fi

complete_message Y

backToSetupScreenOption
