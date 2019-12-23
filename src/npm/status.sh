DIR="$1"
source $DIR/src/utils.sh
source $DIR/src/npm/utils.sh

info "⚙️  ${TEXT_BOLD}NPM status${TEXT_NORMAL}" Y
text_space_below "This will check if the 'nvm' and 'npm' commands can be used"

# load nvm in this file
NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if command_exists nvm; then
    success "  ✓  NVM is installed"

    echo ""

    if command_exists npm; then
        success "  ✓  NPM is installed"

        text_space 'Installed Global Packages, matching source file'
        npm_global_installed_packages_list

        text_space 'Missing Extensions, exists in source file but are not installed'
        npm_not_global_installed_packages_list

        complete_message Y
    else
        err "     NPM is not installed" Y
    fi
else
    err "     NPM is not installed" Y
fi

backToStatusScreenOption
