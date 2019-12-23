DIR="$1"
source $DIR/src/utils.sh

info "🛠  SSH setup" A

CONFIG_SRC="${DIR}/dotfiles/ssh/config"
CONFIG_DEST="${HOME}/.ssh/config"

if find_file_location "$CONFIG_SRC" ".ssh/config"; then
    # check if directory exists
    if [ ! -d "${HOME}/.ssh" ]; then
        if ask "Could not find directory ${TEXT_BOLD}${HOME}/.ssh${TEXT_NORMAL}, do you want to created it?" Y; then
            echo "Creating directory ${TEXT_BOLD}${HOME}/.ssh${TEXT_NORMAL}"
            mkdir "${HOME}/.ssh"
        fi
    fi
    createLink "$CONFIG_SRC" "$CONFIG_DEST"
    symlink_location_matches "$CONFIG_DEST" "$CONFIG_SRC" 
fi

complete_message Y

backToSetupScreenOption
