#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/vscode.sh

info "🛠  Visual Studio Code status" A
text_space_below "This will check if the 'code' command can be used\nand which extensions are installed"

if command_exists code; then
    success "[x] Visual Studio Code is installed"

    text_space_above 'Installed Extensions, matching source file'
    vscode_installed_extensions_list

    text_space_above 'Installed Extensions, missing in source file'
    vscode_missing_source_file_extensions_list

    text_space_above 'Missing Extensions, exists in source file but are not installed'
    vscode_not_installed_extensions_link

    complete_message Y

else
    err "Visual Studio Code is not installed" Y
fi