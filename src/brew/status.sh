#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/src/utils.sh
source $DIR/src/brew/utils.sh

info "⚙️  ${TEXT_BOLD}Brew status${TEXT_NORMAL}" Y
text_space_below "This will check if the 'brew' command can be used\nand which formulas are installed"

if command_exists brew; then
    success "  ✓  Brew is installed"

    text_space 'Installed Formulas, matching source file'
    brew_installed_formulas

    text_space 'Installed Formulas, missing in source file'
    brew_missing_source_file_formulas

    text_space 'Missing Formulas, exists in source file but are not installed'
    brew_not_installed_extensions

    complete_message Y

else
    err "     Brew is not installed" Y
fi

backToStatusScreenOption
