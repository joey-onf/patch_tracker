#!/bin/bash

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function __anonymous()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5122')
    ref+=('https://gerrit.opencord.org/c/voltha-protos/+/34206')
    ref+=('https://gerrit.opencord.org/c/openolt/+/34421')

    return
}

__anonymous "$@"
unset __anonymous

# [EOF]
