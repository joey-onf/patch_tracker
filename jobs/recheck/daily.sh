#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_recheck_daily()
{
    local -n ref=$1; shift

    # voltha-docs:bbsim
    ref+=('https://gerrit.opencord.org/c/voltctl/+/34780')

    return
}

# [EOF]
