# color vaules
COLOR_BLACK='\033[30m'
COLOR_RED='\033[31m'
COLOR_GREEN='\033[32m'
COLOR_YELLOW='\033[33m'
COLOR_BLUE='\033[34m'
COLOR_MAGENTA='\033[35m'
COLOR_CYAN='\033[36m'
COLOR_LIGHT_GRAY='\033[37m'
COLOR_DARK_GRAY='\033[38m'
COLOR_NORMAL='\033[39m'

TEXT_NORMAL=$(tput sgr0)
TEXT_BOLD=$(tput bold)
TEXT_DIM=''

TPUT_NORMAL=$(tput sgr0)
TPUT_BOLD=$(tput bold)
TPUT_RED=$(tput setaf 1)
TPUT_GREEN=$(tput setaf 1)
TPUT_YELLOW=$(tput setaf 3)



# Text Header creator
# $1=TEXT $2=TYPE $=SPACE_BETWEEN
textHeader() {
    # set spacebetween variable 
    if [ "${3:-}" = "Y" ]; then local SPACE_BETWEEN="both";
    elif [ "${3:-}" = "A" ]; then local SPACE_BETWEEN="above";
    elif [ "${3:-}" = "B" ]; then local SPACE_BETWEEN="below";
    else local SPACE_BETWEEN="neither"; fi

    # set text color
    if [ "${2}" = "success" ]; then local COLOR=$COLOR_GREEN;
    elif [ "${2}" = "err" ]; then local COLOR=$COLOR_RED;
    elif [ "${2}" = "warn" ]; then local COLOR=$COLOR_YELLOW;
    elif [ "${2}" = "info" ]; then local COLOR=$COLOR_BLUE;
    else local COLOR=$COLOR_NORMAL; fi

    # print
    [ "${SPACE_BETWEEN}" = "both" ] || [ "${SPACE_BETWEEN}" = "above" ] && echo ''
    echo "${COLOR}${1}${COLOR_NORMAL}"
    [ "${SPACE_BETWEEN}" = "both" ] || [ "${SPACE_BETWEEN}" = "below" ] && echo ''
}

# text defaults 
success() { textHeader "${1}" "success" "${2}"; }
err() { textHeader "${1}" "err" "${2}"; }
warn() { textHeader "${1}" "warn" "${2}"; }
info() { textHeader "${1}" "info" "${2}"; }

text_space() { echo ''; echo  ${1}; echo ''; }
text_space_above() { echo ''; echo  ${1}; }
text_space_below() { echo  ${1}; echo ''; }



# Messages
abort_message() { err "✋ Aborting!" $1; }
complete_message() { info "👊 Complete." $1; }



# Common Options
backToStatusScreenOption() {
    if ask "Do you want to go back to the Status Menu?" Y; then
        "${DIR}/status.sh"
    else
        abort_message Y
        exit
    fi
}
backToSetupScreenOption() {
    if ask "Do you want to go back to the Setup Menu?" Y; then
        "${DIR}/setup.sh"
    else
        abort_message Y
        exit
    fi
}



# Ask Prompt
# https://gist.github.com/davejamesmiller/1965569
ask() {
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        printf "$1 [$prompt]: "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

# check if command exists
command_exists() {
    if command -v $@ >/dev/null 2>&1; then
        return 0;
    fi
    return 1;
}
command_does_not_exist() {
    if command -v $@ >/dev/null 2>&1; then
        return 1;
    fi
    return 0;
}

# ask if overwriting a file already exists
overwrite() {
    if [ -a "${1}" ]; then
        # ask if it should be overwritten 
        echo ''
        if ! ask "${TEXT_BOLD}${1}${TEXT_NORMAL} already exists, overwrite?" N; then
            abort_message Y;
            exit 1;
        fi
    fi
}

# create a symlink, allow skipping
createLink() {
    if [ -a "$2" ]; then
        # ask if it should be overwritten 
        echo ''
        if ! ask "${TEXT_BOLD}${1}${TEXT_NORMAL} already exists, overwrite?" N; then
            echo "   Skipped symlinking"
        else
            echo "Symlinking ${TEXT_BOLD}${2}${TEXT_NORMAL} to ${TEXT_BOLD}${1}${TEXT_NORMAL}..."
            ln -sfn "${1}" "${2}"
        fi
    else 
        echo "Symlinking ${TEXT_BOLD}${2}${TEXT_NORMAL} to ${TEXT_BOLD}${1}${TEXT_NORMAL}..."
        ln -sfn "${1}" "${2}"
    fi
}

# check if a file can be found, can be used in conditional
# $1=PATH_TO_FILE  $2=NAME_OF_FILE
find_file_location() {
    if [ -a "$1" ]; then { success " ✓  ${2} found" A; local STATUS=0; };
    else { err "    ${2} not found" A; local STATUS=1; } fi
    echo  "Location: ${TEXT_DIM}${1}${TEXT_NORMAL}"
    return $STATUS
}
find_file_location_only_visual() {
    if [ -a "$1" ]; then { success " ✓ ${2} found" A; };
    else { err "   ${2} not found" A; } fi
    echo  "Location: ${TEXT_DIM}${1}${TEXT_NORMAL}"
}

# $1=FILE_TO_CHECK $2=SOURCE
symlink_location_matches() {
    local SYMLINK_DEST=$(readlink "$1")
    if [ "$SYMLINK_DEST" = "$2" ]; then
        text_space_above "${COLOR_GREEN} ✓  Symlink connected ${COLOR_NORMAL}"
    else
        text_space_above "${COLOR_RED}    Symlink not connected ${COLOR_NORMAL}"
    fi
    echo  "Location: ${TEXT_DIM}${1}${TEXT_NORMAL}"
    echo  "Source: ${TEXT_DIM}${2}${TEXT_NORMAL}"
}



# prompt
install_brew_prompt() {
    if command_does_not_exist brew; then
        warn "Brew is not installed on this comupter." A

        if ask "Do you want to install Brew now?" Y; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        else
            abort_message Y
            exit 1;
        fi
    else
        success " ✓  Brew is installed" A
    fi
}

install_vscode_prompt() {
    if command_does_not_exist code; then
        if ask "Do you want to install Visual Studio Code now? (brew)" Y; then
            install_brew_prompt
            brew cask install visual-studio-code
        else
            abort_message Y
            exit 1;
        fi
    else
        success " ✓  Visual Studio Code is installed" A
    fi
}
