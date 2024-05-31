#!/bin/bash
# by @vbetsch -> https://github.com/vbetsch

source 'common/_style.sh'
source 'common/variables.sh'
source 'common/functions.sh'

# --- FUNCTIONS ---
function _test_file_not_exist() {
    args=('--file-or-directory')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    test_file_not_exist "$1" "Please use ${_STYLE_BOLD}install.sh${_STYLE_RESET}"
}

# --- CHECKS BEFORE ---
_test_file_not_exist "$IMAGE_FILE_BIN_PATH"
_test_file_not_exist "$SHARE_APP_PATH"
_test_file_not_exist "$DESKTOP_FILE_APP_PATH"

# --- STEP 1 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Removing AppImage symbolic link${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm "$IMAGE_FILE_BIN_PATH"

# --- STEP 2 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Removing share folder${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm -rf "$SHARE_APP_PATH"

# --- STEP 3 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Removing desktop file${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm "$DESKTOP_FILE_APP_PATH"

# --- END ---
echo -e "$_STYLE_DONE"
