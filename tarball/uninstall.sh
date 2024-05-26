#!/bin/bash
# by @vbetsch -> https://github.com/vbetsch

# =============================== COMMON ===============================

# Styles
_STYLE_RESET='\033[0m'
_STYLE_BOLD='\033[01m'
_STYLE_COLOR_CYAN='\033[36m'
_STYLE_COLOR_RED='\033[31m'
_STYLE_COLOR_GREEN='\033[32m'
_STYLE_COLOR_YELLOW='\033[93m'
_STYLE_COLOR_PURPLE='\033[34m'
_STYLE_ARROW='➔ '
_STYLE_ELLIPSIS='...'
_STYLE_ERROR="${_STYLE_COLOR_RED}ERROR${_STYLE_RESET}"
_STYLE_WARN="${_STYLE_COLOR_YELLOW}WARNING${_STYLE_RESET}"
_STYLE_INFO="${_STYLE_COLOR_CYAN}INFO${_STYLE_RESET}"
_STYLE_OK="${_STYLE_COLOR_GREEN}OK${_STYLE_RESET}"
_STYLE_DONE="${_STYLE_COLOR_GREEN}Done${_STYLE_RESET}"

# =============================== SPECIFIC ===============================

# --- VARIABLES ---
bin_dir='/usr/local/bin'
share_dir="$HOME/.local/share"
applications_dir="$HOME/.local/share/applications"
app_name='LifeManager'
version='7.6.2'

image_file_name="${app_name}-${version}.AppImage"

image_file_bin_path="${bin_dir}/${image_file_name}"
share_app_path="${share_dir}/${app_name}"
desktop_file_app_path="${applications_dir}/${app_name}.desktop"

# --- FUNCTIONS ---
function test_update() {
    args=('--directory')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    if [ ! -f "$1" ] && [ ! -d "$1" ] && [ ! -L "$1" ];then
        echo -e "${_STYLE_ERROR}${_STYLE_COLOR_RED}: ${1} already exists. Please use ${_STYLE_BOLD}install.sh${_STYLE_RESET}"
        exit 1
    fi
}

# --- CHECKS BEFORE ---
test_update $image_file_bin_path
test_update $share_app_path
test_update $desktop_file_app_path

# --- STEP 1 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Remove AppImage symlink${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm "$image_file_bin_path"

# --- STEP 2 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Remove share folder${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm -rf "$share_app_path"

# --- STEP 3 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Remove desktop file${_STYLE_ELLIPSIS}${_STYLE_RESET}"
sudo rm "$desktop_file_app_path"

# --- END ---
echo -e $_STYLE_DONE
