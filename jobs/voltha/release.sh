#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_voltha_release()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5004')
    ref+=('https://jira.opencord.org/browse/VOL-5019')
    ref+=('https://github.com/joey-onf/todo/tree/origin/master/release')

    if [[ -v argv_edit ]]; then
        local path="$HOME/projects/sandbox/todo/release"
        readarray -t fyls < <(find "$path" -type f -print)
        add2files "${fyls[@]}"
    fi

    return
}

# [EOF]
