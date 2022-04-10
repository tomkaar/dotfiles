


ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )
source $ROOT_DIR/src/utils.sh
source $ROOT_DIR/source.sh

vscode_extension_get_name() {
    echo "$(cut -d'.' -f2 <<< ${1})"
}
vscode_extension_get_author() {
    echo "$(cut -d'.' -f1 <<< ${1})"
}

vscode_install_extensions() {
    VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS="$(code --list-extensions)"
    IFS=' ' read -a array <<< $VISUAL_STUDIO_CODE_EXTENSIONS; 

    echo ""

    selectedExtensions=()

    for extension in "${array[@]}"; do   
        if [[ "$VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS" == *"${extension}"* ]]; then
            echo  "${COLOR_GREEN} ✓  $(vscode_extension_get_name $extension)${COLOR_NORMAL} by $(vscode_extension_get_author $extension) is installed"
        else
            if ask "Do you want to install ${COLOR_YELLOW}$(vscode_extension_get_name $extension)${COLOR_NORMAL} now?" Y; then
                selectedExtensions+=("${extension}")
            fi
        fi
    done

    echo ""

    for extension in "${selectedExtensions[@]}"; do
        info "Installing ${extension}"
        code --install-extension ${extension}
    done

    echo ""
}


#
# Lists
#

vscode_extension_check() {
    if [ "${3:-}" = 'Y' ]; then
        success " ✓  ${1} by ${2}"
    elif [ "${3:-}" = 'D' ]; then
        warn " ✓  ${1} by ${2}"
    else
        err "    ${1} by ${2}"
    fi
}

vscode_installed_extensions_list() {
    local VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS="$(code --list-extensions)"
    IFS=' ' read -a array <<< $VISUAL_STUDIO_CODE_EXTENSIONS;

    for element in "${array[@]}"
    do
        if [[ "$VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS" == *"${element}"* ]]; then
             vscode_extension_check $(vscode_extension_get_name $element) $(vscode_extension_get_author $element) Y
        fi
    done
}

vscode_missing_source_file_extensions_list() {
    IFS=' ' read -a array <<< $(code --list-extensions | paste -sd " " -);

    for element in "${array[@]}"
    do
        if ! [[ "$VISUAL_STUDIO_CODE_EXTENSIONS" == *"${element}"* ]]; then
            vscode_extension_check $(vscode_extension_get_name $element) $(vscode_extension_get_author $element) D
        fi
    done
}

vscode_not_installed_extensions_link() {
    local VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS="$(code --list-extensions)"
    IFS=' ' read -a array <<< $VISUAL_STUDIO_CODE_EXTENSIONS;

    for element in "${array[@]}"
    do
        if ! [[ "$VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS" == *"${element}"* ]]; then
            vscode_extension_check $(vscode_extension_get_name $element) $(vscode_extension_get_author $element)
        fi
    done
}