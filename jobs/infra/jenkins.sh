#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_infra_jenkins()
{
    local -n ref=$1; shift
    
    ref+=('https://jira.opennetworking.org/browse/INF-875')
    return
}

: # Return success ($?==0) for source $script

# [EOF]