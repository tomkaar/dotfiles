DIR="$1"
source $DIR/src/utils.sh

SET_PATH=$(defaults read com.googlecode.iterm2.plist PrefsCustomFolder -string)
DESIRED_PATH="${DIR}/dotfiles/iterm2"

info "⚙️  ${TEXT_BOLD}iTerm2 status${TEXT_NORMAL}" Y
echo  "This will check if the file can be located\nand check if the paths match."

if [ "${SET_PATH}" == "${DESIRED_PATH}" ]; then
    success " ✓  The paths seems to match!" A
else
    err "    The paths does not seem to match" A
fi

echo  "Set path: ${TEXT_DIM}${SET_PATH}${TEXT_NORMAL}"
echo  "Desired path: ${TEXT_DIM}${DESIRED_PATH}${TEXT_NORMAL}"

# echo $SET_PATH

complete_message Y

backToStatusScreenOption
