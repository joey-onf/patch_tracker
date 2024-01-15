#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_voltha-openonu-adapter-go_daily()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5198')
    ref+=('https://gerrit.opencord.org/c/voltha-openonu-adapter-go/+/34777')
    ref+=('https://gerrit.opencord.org/c/voltha-openonu-adapter-go/+/34315')
    return
}

# [EOF]
