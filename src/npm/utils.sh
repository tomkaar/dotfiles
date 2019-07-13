#!/usr/bin/env bash
set -e

ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )
source $ROOT_DIR/src/utils.sh
source $ROOT_DIR/source.sh

git_install_global_packages() {

    text_space_above "Global Packages"

    IFS=' ' read -a array <<< $GLOBAL_NPM_PACKAGES;

    info "Installing global packages"
    for package in "${array[@]}"; do
      # currently unable to check globally installed packages
      echo ''
      if ask "Do you want to install ${package} now?" Y; then
          info "Installing ${package}"
          npm install --global ${package}
      fi
      echo ''
    done
    

    echo ''
}