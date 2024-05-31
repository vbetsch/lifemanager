#!/bin/bash
# by @vbetsch -> https://github.com/vbetsch

source 'common/_style.sh'
source 'common/variables.sh'
source 'common/functions.sh'

# --- VARIABLES ---
favicon_file_local_path="./${FAVICON_FILE_NAME}"

desktop_content_file="
[Desktop Entry]
Name=${APP_NAME}
Exec=${IMAGE_FILE_APP_PATH} %u
Type=Application
Categories=Development;
Terminal=false
Icon=${FAVICON_FILE_APP_PATH}
"

# --- FUNCTIONS ---
function _test_file_exist() {
    args=('--file-or-directory')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    test_file_exist "$1" "Please use ${_STYLE_BOLD}update.sh${_STYLE_RESET}"
}

# --- CHECKS BEFORE ---
test_file_required "$IMAGE_FILE_LOCAL_PATH"
test_file_required "$favicon_file_local_path"

test_directory_required "$BIN_DIR"
test_directory_required "$SHARE_DIR"
test_directory_required "$APPLICATIONS_DIR"

_test_file_exist "$IMAGE_FILE_BIN_PATH"
_test_file_exist "$IMAGE_FILE_APP_PATH"
_test_file_exist "$DESKTOP_FILE_APP_PATH"
_test_file_exist "$FAVICON_FILE_APP_PATH"

# --- STEP 1 ---
if [ ! -d "$SHARE_APP_PATH" ];then
    echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Creating ${SHARE_APP_PATH} directory${_STYLE_ELLIPSIS}${_STYLE_RESET}"
    sudo mkdir -v "$SHARE_APP_PATH"
fi

# --- STEP 2 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Creating desktop file${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo cp "$IMAGE_FILE_LOCAL_PATH" "$IMAGE_FILE_APP_PATH"
sudo cp "$favicon_file_local_path" "$FAVICON_FILE_APP_PATH"
echo "$desktop_content_file" > "$DESKTOP_FILE_APP_PATH"

# --- STEP 3 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Creating a symbolic link${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo ln -s "$IMAGE_FILE_APP_PATH" "$BIN_DIR"

# --- END ---
echo -e "$_STYLE_DONE"
