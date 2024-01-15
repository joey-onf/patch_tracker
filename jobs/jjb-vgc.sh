#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_jjb-vgc()
{
    local -n ref=$1; shift

    ## Create new JJB job for VGC
    ref+=('https://jira.opencord.org/browse/VOL-5220')
    ref+=('https://gerrit.opencord.org/c/voltha-system-tests/+/34023')
    ref+=('https://gerrit.opencord.org/c/voltha-system-tests/+/34423')
    return
}

# [EOF]
