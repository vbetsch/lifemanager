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
app_name='LifeManager'
version='7.6.2'
project_dir="$HOME/Scripts/lifemanager"
tarball_file='lifemanager.tar.gz'

tarball_final_dir="${app_name}"
dist_dir="${project_dir}/dist"
tarball_content_dir="${project_dir}/tarball"

image_file_name="${app_name}-${version}.AppImage"
image_file_path="${dist_dir}/${image_file_name}"

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
function test_dir() {
    args=('--directory')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    if [ ! -d "$1" ];then
        echo -e "${_STYLE_ERROR}${_STYLE_COLOR_RED}: ${1} is not a directory${_STYLE_RESET}"
        exit 1
    fi
}

# --- CHECKS BEFORE ---
test_dir $project_dir
test_dir $dist_dir
test_dir $tarball_content_dir
test_file $image_file_path

# --- STEP 0 ---
if [ -f "$tarball_file" ];then
    rm "$tarball_file"
fi

# --- STEP 1 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Create temporary folder${_STYLE_ELLIPSIS}${_STYLE_RESET}"
mkdir -p "$tarball_final_dir"
cp "$image_file_path" "$tarball_final_dir"
cp -r "${tarball_content_dir}/." "$tarball_final_dir"

# --- STEP 2 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Building archive${_STYLE_ELLIPSIS}${_STYLE_RESET}"
tar -czvf "${tarball_file}" "${tarball_final_dir}"

# --- STEP 3 ---
echo -e "${_STYLE_COLOR_PURPLE}${_STYLE_ARROW}Removing temporary folder${_STYLE_ELLIPSIS}${_STYLE_RESET}"
rm -rf "$tarball_final_dir"

# --- END ---
echo -e $_STYLE_DONE
