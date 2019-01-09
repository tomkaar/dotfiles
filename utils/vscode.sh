#!/usr/bin/env bash
set -e

VSCODE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
VSCODE_PARENT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
source $VSCODE_DIR/utils.sh
source $VSCODE_PARENT_DIR/source.sh

vscode_extension_get_name() {
    echo "$(cut -d'.' -f2 <<< ${1})"
}
vscode_extension_get_author() {
    echo "$(cut -d'.' -f1 <<< ${1})"
}

vscode_install_extensions() {
    VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS="$(code --list-extensions)"
    IFS=' ' read -a array <<< $VISUAL_STUDIO_CODE_EXTENSIONS; 

    text_space_above "Extensions"

    for extension in "${array[@]}"
    do   
        if ! [[ "$VISUAL_STUDIO_CODE_INSTALLED_EXTENSIONS" == *"${extension}"* ]]; then
            warn "${COLOR_YELLOW}[ ] $(vscode_extension_get_name $extension)${COLOR_NORMAL} by $(vscode_extension_get_author $extension) is not installed" A
            if ask "Do you want to install ${COLOR_YELLOW}$(vscode_extension_get_name $extension)${COLOR_NORMAL} now?" Y; then
                info "Installing ${extension}"
                code --install-extension ${extension}
            fi  
            echo ''
        else
            echo -e "${COLOR_GREEN}[x] $(vscode_extension_get_name $extension)${COLOR_NORMAL} by $(vscode_extension_get_author $extension) is installed"
        fi
    done
}


#
# Lists
#

vscode_extension_check() {
    if [ "${3:-}" = 'Y' ]; then
        success "[x] ${1} by ${2}"
    elif [ "${3:-}" = 'D' ]; then
        warn "[x] ${1} by ${2}"
    else
        err "[ ] ${1} by ${2}"
    fi
}

vscode_installed_extensions_list(){
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