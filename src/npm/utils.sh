ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )
source $ROOT_DIR/src/utils.sh
source $ROOT_DIR/source.sh

# load nvm in this file
NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

npm_install_global_packages() {

    text_space_above "Global Packages"

    IFS=' ' read -a array <<< $GLOBAL_NPM_PACKAGES;

    info "Installing global packages"
    for package in "${array[@]}"; do
        local STATUS=$(
            npm list -g --depth 1 | grep ${package} > /dev/null 2>&1
            EXIT=$?
            echo $EXIT
        )
        echo ''
        if [ $STATUS != 0 ]; then
            if ask "Do you want to install ${package} now?" Y; then
                info "Installing ${package}"
                npm install --global ${package}
                echo  "${COLOR_GREEN}  ✓  ${package} has been installed${COLOR_NORMAL}"
            else
                echo "Skipping"
            fi
        else
             echo  "${COLOR_GREEN}  ✓  ${package} has been installed${COLOR_NORMAL}"
        fi
    done
}

#
# List
#

npm_global_installed_packages_check() {
    if [ "${2:-}" = 'Y' ]; then
        success "  ✓  ${1}"
    elif [ "${2:-}" = 'D' ]; then
        warn "  ✓  ${1}"
    else
        err "    ${1}"
    fi
}

npm_global_installed_packages_list(){
    IFS=' ' read -a array <<< $GLOBAL_NPM_PACKAGES;

    for package in "${array[@]}"; do
        local STATUS=$(
            npm list -g --depth 1 | grep ${package} > /dev/null 2>&1
            EXIT=$?
            echo $EXIT
        )
        if [ $STATUS != 1 ]; then
            npm_global_installed_packages_check $package Y
            echo ""
        fi
    done
}

npm_not_global_installed_packages_list(){
    IFS=' ' read -a array <<< $GLOBAL_NPM_PACKAGES;

    for package in "${array[@]}"; do
        local STATUS=$(
            npm list -g --depth 1 | grep ${package} > /dev/null 2>&1
            EXIT=$?
            echo $EXIT
        )
        if [ $STATUS != 0 ]; then
            npm_global_installed_packages_check $package
            echo ""
        fi
    done
}

# propt
install_nvm_prompt() {
    if command_does_not_exist nvm; then
        warn "NVM is not installed on this comupter." A

        if ask "Do you want to install NVM now?" Y; then
            /usr/bin/ruby  "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash)"
        else
            abort_message Y
            exit 1;
        fi
    else
        success " ✓  NVM is installed" A
    fi
}