#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_reviews_pending()
{
    local -n ref=$1; shift

    ref+=('https://gerrit.opencord.org/c/openolt/+/34649')
    return
}

# [EOF]