#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_infra_docs()
{
    local -n ref=$1; shift

    ## atlassian/gerrit access docs
    refs+=('https://gerrit.opencord.org/c/infra-docs/+/34845')
    
    # Gerrit ACLs
    ref+=('https://gerrit.opencord.org/c/infra-docs/+/34840')
    return
}

# [EOF]
