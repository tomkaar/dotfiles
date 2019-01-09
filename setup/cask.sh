#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/cask.sh

info "🛠  Cask setup" A

install_brew_prompt
cask_install_casks

complete_message B
