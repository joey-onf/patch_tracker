# -*- sh -*-
## -----------------------------------------------------------------------
## Intent: Common functions
## -----------------------------------------------------------------------

[[ -v DEBUG ]] && echo "[${BASH_SOURCE[0]##*/}] BEGIN"

## -----------------------------------------------------------------------
## Intent: Display an error mmessage then exit
## -----------------------------------------------------------------------
function error()
{
    echo "** ${FUNCNAME[1]} ERROR: $*"
    exit 1
}

## -----------------------------------------------------------------------
## Intent: Display a message on callers behalf
## -----------------------------------------------------------------------
function func_echo()
{
    echo "** ${FUNCNAME[1]}: $*"
    return
}

## -----------------------------------------------------------------------
## Intent: Helper method
## -----------------------------------------------------------------------
## Usage : local path="$(join_by '/' 'lib' "${fields[@]}")"
## -----------------------------------------------------------------------
function join_by()
{
    local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi;
}

## -----------------------------------------------------------------------
## Intent: Display a message decorated for visiblity
## -----------------------------------------------------------------------
function banner()
{
    
    cat <<EOM

** -----------------------------------------------------------------------
EOM

    local val
    for val in "$@";
    do
        printf '** %s\n' "$val"
    done
#    $(join_by "\n** " "$@")
    cat <<EOM
** -----------------------------------------------------------------------
EOM
    return
}

## -----------------------------------------------------------------------
## Intent: Display a message decorated for visiblity
## -----------------------------------------------------------------------
function nothing_to_do()
{
    declare -a buffer=()
    buffer+=("${FUNCNAME} for")

    [[ $# -gt 0 ]] \
        && { buffer+=("$@"); } \
        || { buffer+=("${FUNCNAME[1]}"); }

    local msg="${buffer[@]}"
    banner "$msg"
    return
}

[[ -v DEBUG ]] && echo "[${BASH_SOURCE[0]##*/}] END"

# [EOF]
