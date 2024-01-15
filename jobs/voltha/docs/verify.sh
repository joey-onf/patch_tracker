#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_voltha_docs_verify()
{
    local -n ref=$1; shift

    # Define target git-submodules
    ref+=('https://gerrit.opencord.org/c/voltha-docs/+/34831')
    
    # Define constants tab and newline
    ref+=('https://gerrit.opencord.org/c/onf-make/+/34837')

    # Code review input: Document jenkins job 'trigger-comments' on docs.voltha.org
    ref+=('https://jira.opencord.org/browse/VOL-5237')
    
    return
}

# [EOF]
