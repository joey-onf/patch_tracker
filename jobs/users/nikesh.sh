#!/bin/bash

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function __anonymous()
{
    local -n ref=$1; shift

    if true; then
        # Duplicate package error
        ref+=('https://jira.opencord.org/browse/VOL-5231')
    else
        :
        # ref+=()
    fi
    

    return
}

__anonymous "$@"
unset __anonymous

# [EOF]
