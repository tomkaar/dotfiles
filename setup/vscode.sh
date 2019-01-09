#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/vscode.sh

info "🛠  Visual Studio Code setup" A

install_vscode_prompt
vscode_install_extensions

complete_message Y
