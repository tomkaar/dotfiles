#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/cask.sh

info "⚙️  ${TEXT_BOLD}Cask status${TEXT_NORMAL}" Y
text_space_below "This will check if the 'brew' command can be used\nand which formulas are installed"

if command_exists brew; then
    success " [x] Brew is installed"

    text_space 'Installed Casks, matching source file'
    cask_installed_formulas_list

    text_space 'Installed Casks, missing in source file'
    cask_missing_source_file_formulas_list

    text_space 'Missing Casks, exists in source file but are not installed'
    cask_not_installed_casks_list

    complete_message Y

else
    err " [ ] Brew is not installed" Y
fi
