#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_onos_daily()
{
    local -n ref=$1; shift    

    ref+=('https://jira.opencord.org/browse/VOL-4805')
    ref+=('https://jira.opencord.org/browse/VOL-4806')

    ref+=('https://jira.opennetworking.org/browse/INF-901')
    return
}

# [EOF]