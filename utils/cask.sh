#!/usr/bin/env bash
set -e

CASK_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CASK_PARENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
source $CASK_DIR/utils.sh
source $CASK_PARENT_DIR/source.sh

cask_install_casks() {
    
    text_space_above "Casks"

    IFS=' ' read -a array <<< $BREW_CASKS;
    for cask in "${array[@]}"; do
        if brew cask list $cask > /dev/null; then
            success " ✓  ${cask} is installed"
        else
            echo ''
            # The package is not installed
            info "    ${cask} is not installed"
            if ask "Do you want to install ${cask} now?" Y; then
                info "Installing ${cask}"
                brew cask install ${cask}
            fi
            echo ''
        fi
    done

    echo ''
}



#
# Lists
#

cask_installed_formulas_list(){
    local BREW_INSTALLED_FORMULAS="$(brew cask list)"
    IFS=' ' read -a array <<< $BREW_CASKS;

    for element in "${array[@]}"
    do
        if [[ "$BREW_INSTALLED_FORMULAS" == *"${element}"* ]]; then
             success "  ✓  ${element}"
        fi
    done
}

cask_missing_source_file_formulas_list() {
    IFS=' ' read -a array <<< $(brew cask list | paste -sd " " -);

    for element in "${array[@]}"
    do
        if ! [[ "$BREW_CASKS" == *"${element}"* ]]; then
            warn "  ✓  ${element}"
        fi
    done
}

cask_not_installed_casks_list() {
    local BREW_INSTALLED_FORMULAS="$(brew cask list)"
    IFS=' ' read -a array <<< $BREW_CASKS;

    for element in "${array[@]}"
    do
        if ! [[ "$BREW_INSTALLED_FORMULAS" == *"${element}"* ]]; then
            err "     ${element}"
        fi
    done
}