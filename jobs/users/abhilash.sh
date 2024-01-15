#!/bin/bash

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function __anonymous()
{
    local -n ref=$1; shift

    if false; then
        nothing_to_do
    else
        ## golang upgrade
        
        ref+=("https://jira.opencord.org/browse/VOL-5222")

        # makefiles/docker/include.mk # --is-stdin
        ref+=('https://gerrit.opencord.org/c/voltha-protos/+/34867')

        # makefiles/golang/upgrade.mk
        ref+=('https://gerrit.opencord.org/c/voltha-protos/+/34868')

    fi
    
    return
}

__anonymous "$@"
unset __anonymous

# [EOF]
