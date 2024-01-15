#!/bin/bash

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function __anonymous()
{
    local -n ref=$1; shift

    nothing_to_do

    return
}

__anonymous "$@"
unset __anonymous

# [EOF]
