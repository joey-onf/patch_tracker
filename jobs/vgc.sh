#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_vgc()
{
    local -n ref=$1; shift

    ref+=('https://gerrit.opencord.org/c/voltha-docker-tools/+/34870')

    
    # Dependent packages
    ref+=('https://gerrit.opencord.org/c/voltha-docker-tools/+/34875')
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34175')
    ref+=('https://gerrit.opencord.org/c/voltha-system-tests/+/34876')
    # ref+=('https://jira.opencord.org/browse/VOL-4805')
    return
}

# [EOF]
