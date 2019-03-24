#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/src/utils.sh
source $DIR/src/brew/utils.sh

info "🛠  Brew setup" A

install_brew_prompt
brew_install_formulas

# create nvm directory
mkdir ~/.nvm

complete_message B

backToSetupScreenOption
