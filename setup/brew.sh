#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/brew.sh

info "🛠  Brew setup" A

install_brew_prompt
brew_install_formulas

# create nvm directory
mkdir ~/.nvm

complete_message B

backToSetupScreenOption
