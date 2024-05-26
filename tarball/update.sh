#!/bin/bash
# by @vbetsch -> https://github.com/vbetsch

source common.sh

# --- VARIABLES ---
image_file_local_path="./${IMAGE_FILE_NAME}"
image_file_app_path="${SHARE_DIR}/${APP_NAME}/${IMAGE_FILE_NAME}"

favicon_file_name='favicon.ico'
favicon_file_app_path="${SHARE_APP_PATH}/${favicon_file_name}"

# --- FUNCTIONS ---
function test_file() {
    args=('--file')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    if [ ! -f "$1" ];then
        echo -e "${_STYLE_ERROR}${_STYLE_COLOR_RED}: ${1} is not a file${_STYLE_RESET}"
        exit 1
    fi
}
function test_update() {
    args=('--file-or-directory')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    if [ ! -f "$1" ] && [ ! -L "$1" ] && [ ! -d "$1" ];then
        echo -e "${_STYLE_ERROR}${_STYLE_COLOR_RED}: ${1} not exists. Please reinstall.${_STYLE_RESET}"
        exit 1
    fi
}

# --- CHECKS BEFORE ---
test_file $image_file_local_path
test_update $IMAGE_FILE_BIN_PATH
test_update $image_file_app_path
test_update $DESKTOP_FILE_APP_PATH
test_update $favicon_file_app_path

# --- STEP 1 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Removing AppImage symbolic link${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm "$image_file_app_path"
sudo rm "$IMAGE_FILE_BIN_PATH"

# --- STEP 2 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Update AppImage${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo cp "$image_file_local_path" "$image_file_app_path"

# --- STEP 3 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Recreating the symbolic link${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo ln -s "$image_file_app_path" "$BIN_DIR"

# --- END ---
echo -e $_STYLE_DONE
