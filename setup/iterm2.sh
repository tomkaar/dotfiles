#!/usr/bin/env bash
set -e

DIR="$1"
source $DIR/utils/utils.sh
source $DIR/utils/bash.sh

info "🛠  ${TEXT_BOLD}iTerm2 setup${TEXT_NORMAL}" A

defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${DIR}/dotfiles/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

success " ✓  Link has been created" A 
echo -e "Location: ${TEXT_DIM}${DIR}/dotfiles/iterm2${TEXT_NORMAL}"

killall "cfprefsd" > /dev/null 2>&1

text_space_above "Note that these changes may take some time to take effect."

complete_message Y

backToSetupScreenOption
