#!/usr/bin/env bash
set -e

BASH_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASH_PARENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
source $BASH_DIR/utils.sh
source $BASH_PARENT_DIR/source.sh

brew_install() {

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