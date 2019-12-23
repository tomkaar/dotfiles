DIR="$1"
source $DIR/src/utils.sh
source $DIR/src/npm/utils.sh

info "🛠  Npm setup (global packages)" A

git_install_global_packages

complete_message Y

backToSetupScreenOption
