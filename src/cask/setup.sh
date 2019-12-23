DIR="$1"
source $DIR/src/utils.sh
source $DIR/src/cask/utils.sh

info "🛠  Cask setup" A

install_brew_prompt
cask_install_casks

complete_message B

backToSetupScreenOption
