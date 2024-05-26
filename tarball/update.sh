#!/bin/bash
# by @vbetsch -> https://github.com/vbetsch

source common.sh

# --- FUNCTIONS ---
function _test_file_not_exist() {
    args=('--file-or-directory')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    test_file_not_exist "$1" "Please reinstall."
}

# --- CHECKS BEFORE ---
test_file_required $IMAGE_FILE_LOCAL_PATH
_test_file_not_exist $IMAGE_FILE_BIN_PATH
_test_file_not_exist $IMAGE_FILE_APP_PATH
_test_file_not_exist $DESKTOP_FILE_APP_PATH
_test_file_not_exist $FAVICON_FILE_APP_PATH

# --- STEP 1 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Removing AppImage symbolic link${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm "$IMAGE_FILE_APP_PATH"
sudo rm "$IMAGE_FILE_BIN_PATH"

# --- STEP 2 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Update AppImage${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo cp "$IMAGE_FILE_LOCAL_PATH" "$IMAGE_FILE_APP_PATH"

# --- STEP 3 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Recreating the symbolic link${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo ln -s "$IMAGE_FILE_APP_PATH" "$BIN_DIR"

# --- END ---
echo -e $_STYLE_DONE
