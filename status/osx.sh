#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh

info "⚙️  ${TEXT_BOLD}OSX status${TEXT_NORMAL}" Y
echo -e "This will check if the source file can be located"

SSH_SRC="${DIR}/dotfiles/.osx"
SSH_DEST="${HOME}/.ssh/config"

find_file_location "$SSH_SRC" ".osx source"

complete_message Y
