#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_make_daily()
{
    local -n ref=$1; shift

    # repo:onf-make migration patch #1
    # ref+=('https://gerrit.opencord.org/c/voltha-docs/+/34797')

    ## Undef cleanup for target lint-make
    # ref+=('https://gerrit.opencord.org/c/onf-make/+/34758')

    ## Edits for repo:voltha-docs use -- merged
    # ref+=('https://gerrit.opencord.org/c/onf-make/+/34774')

    return
}

# [EOF]
