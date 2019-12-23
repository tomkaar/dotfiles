DIR="$1"
source $DIR/src/utils.sh
source $DIR/src/brew/utils.sh

info "🛠  Brew setup" A

install_brew_prompt
brew_install_formulas

complete_message B

backToSetupScreenOption
