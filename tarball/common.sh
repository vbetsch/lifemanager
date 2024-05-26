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

# --- VARIABLES ---
version='7.6.2'

APP_NAME='LifeManager'
BIN_DIR='/usr/local/bin'

SHARE_DIR="$HOME/.local/share"
APPLICATIONS_DIR="$HOME/.local/share/applications"
SHARE_APP_PATH="${SHARE_DIR}/${APP_NAME}"

# AppImage
IMAGE_FILE_NAME="${APP_NAME}-${version}.AppImage"
IMAGE_FILE_LOCAL_PATH="./${IMAGE_FILE_NAME}"
IMAGE_FILE_APP_PATH="${SHARE_DIR}/${APP_NAME}/${IMAGE_FILE_NAME}"
IMAGE_FILE_BIN_PATH="${BIN_DIR}/${IMAGE_FILE_NAME}"

# Favicon
FAVICON_FILE_NAME='favicon.ico'
FAVICON_FILE_APP_PATH="${SHARE_APP_PATH}/${FAVICON_FILE_NAME}"

# Desktop file
DESKTOP_FILE_APP_PATH="${APPLICATIONS_DIR}/${APP_NAME}.desktop"

# --- FUNCTIONS ---
function test_file_required() {
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
function test_directory_required() {
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

function test_file_exist() {
    args=('--file-or-directory' '--comment')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    if [ -f "$1" ] || [ -d "$1" ] || [ -L "$1" ];then
        echo -e "${_STYLE_ERROR}${_STYLE_COLOR_RED}: ${1} already exists. ${2}${_STYLE_RESET}"
        exit 1
    fi
}
function test_file_not_exist() {
    args=('--file-or-directory' '--comment')
    if [ ${#} != ${#args[@]} ]; then
      echo -e "${_STYLE_COLOR_RED}ERROR: ${#args[@]} arguments are required in ${FUNCNAME} but ${#} have been set ${_STYLE_RESET}"
      IFS=$' '
      echo -e "Arguments: ${_STYLE_COLOR_CYAN}${args[*]}${_STYLE_RESET}"
      exit 1
    fi
    if [ ! -f "$1" ] && [ ! -d "$1" ] && [ ! -L "$1" ];then
        echo -e "${_STYLE_ERROR}${_STYLE_COLOR_RED}: ${1} not exists. ${2}${_STYLE_RESET}"
        exit 1
    fi
}
