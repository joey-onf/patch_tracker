#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_alex_daily()
{
    local -n ref=$1; shift

    ref+=('https://wiki.opennetworking.org/display/JOEY/SMaRT5g')
    ref+=('https://jira.opennetworking.org/browse/INF-877')
    ref+=('https://opennetworking.org/sustainable-5g')
    ref+=('https://github.com/onosproject/onos-cli/pull/320')
    return
}

# [EOF]
