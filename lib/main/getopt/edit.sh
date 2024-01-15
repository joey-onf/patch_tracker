#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## Intent: Derive path to root from path of sourced script
## -----------------------------------------------------------------------
# function _loader()
# {
#    local cmd="$(readlink --canonicalize-existing "${BASH_SOURCE[0]}")"
#    local root="${cmd::-24}"
#    source "$root/lib/main/editutils.sh"
# }
# _loader

## -----------------------------------------------------------------------
## Intent: Load jobs.sh config scriopts into an editor
## -----------------------------------------------------------------------
function do_edit()
{
    local -n ref=$1  ; shift
    local -n argv=$1 ; shift
    set -- "${argv[@]}"

    declare prefix="$HOME/projects/jobs"
    declare -a ref=()
    ref+=("$prefix/jobs.sh")
    while [[ $# -gt 0 ]]; do
        arg="$1"; shift
 
        ## Remove leading hyphens
        [[ "${arg:0:1}" == '-' ]] && { arg="${arg#"${arg%%[!-]*}"}"; }

        ## Split command line arguments
        ##   [src] voltha-docs-daily
        ##   [dst] voltha/docs/daily(.sh)
        readarray -t -d'-' subdirs < <(printf '%s' "$arg")
        local path="$(join_by '/' "$prefix" 'jobs' "${subdirs[@]}")"
        local path_sh="${path}.sh"

        ## Given a switch 
        if [[ -f "$path_sh" ]]; then
            ref+=("$path_sh")
        elif [ -d "$path" ]; then
            readarray -t paths < <(find "$path" -maxdepth 1 -name '*.sh' -print)
            ref+=("${paths[@]}")
        else
            error "--edit $arg: path does not exist: $path"
        fi
    done

    argv=("$@")
    add2edit "${ref[@]}"
    return
}
