#!/bin/bash
# by @vbetsch -> https://github.com/vbetsch

source common.sh

# --- FUNCTIONS ---
function test_update() {
    args=('--file-or-directory')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    if [ ! -f "$1" ] && [ ! -d "$1" ] && [ ! -L "$1" ];then
        echo -e "${_STYLE_ERROR}${_STYLE_COLOR_RED}: ${1} not exists. Please use ${_STYLE_BOLD}install.sh${_STYLE_RESET}"
        exit 1
    fi
}

# --- CHECKS BEFORE ---
test_update $IMAGE_FILE_BIN_PATH
test_update $SHARE_APP_PATH
test_update $DESKTOP_FILE_APP_PATH

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
echo -e $_STYLE_DONE
