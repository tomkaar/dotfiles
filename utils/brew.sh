#!/usr/bin/env bash
set -e

BREW_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BREW_PARENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
source $BREW_DIR/utils.sh
source $BREW_PARENT_DIR/source.sh

brew_install_formulas() {

    text_space_above "Formulas"

    IFS=' ' read -a array <<< $BREW_FORMULAS;
    for package in "${array[@]}"; do
        if brew ls --versions $package > /dev/null; then
            success "${package} is installed"
        else
            echo ''
            # The package is not installed
            info "${package} is not installed"
            if ask "Do you want to install ${package} now?" Y; then
                info "Installing ${package}"
                brew install ${package}
            fi
            echo ''
        fi
    done

    echo ''
}



#
# Lists
#

brew_installed_formulas(){
    local BREW_INSTALLED_FORMULAS="$(brew list)"
    IFS=' ' read -a array <<< $BREW_FORMULAS;

    for element in "${array[@]}"
    do
        if [[ "$BREW_INSTALLED_FORMULAS" == *"${element}"* ]]; then
            success "[x] ${element}"
        fi
    done
}

brew_missing_source_file_formulas() {
    IFS=' ' read -a array <<< $(brew list | paste -sd " " -);

    for element in "${array[@]}"
    do
        if ! [[ "$BREW_FORMULAS" == *"${element}"* ]]; then
            warn "[x] ${element}"
        fi
    done
}

brew_not_installed_extensions() {
    local BREW_INSTALLED_FORMULAS="$(brew list)"
    IFS=' ' read -a array <<< $BREW_FORMULAS;

    for element in "${array[@]}"
    do
        if ! [[ "$BREW_INSTALLED_FORMULAS" == *"${element}"* ]]; then
            err "[ ] ${element}"
        fi
    done
}
