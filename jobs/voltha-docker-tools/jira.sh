#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function __anonymous()
{
    local -n ref=$1; shift

    if false; then
        nothing_to_do
    else
        ## voltha-docker-tools
        ref+=('https://gerrit.opencord.org/c/voltha-docker-tools/+/34870')
    fi

    return
}

__anonymous "$@"
unset __anonymous

# [EOF]
