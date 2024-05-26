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
