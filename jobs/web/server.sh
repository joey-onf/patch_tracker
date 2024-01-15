#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_web_server()
{
    local -n ref=$1; shift

    ref+=('https://wiki.opennetworking.org/display/BAT/bat-web+Home')
    
    ref+=('https://jira.opennetworking.org/browse/INF-864')
    ref+=('https://jira.opennetworking.org/browse/INF-833')

    ref+=('https://jira.opennetworking.org/browse/INF-837')
    ref+=('https://jira.opennetworking.org/browse/INF-882')
    return
}

: # return success ($?==0) for source $script

# [EOF]
