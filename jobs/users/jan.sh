#!/bin/bash

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function __anonymous()
{
    local -n ref=$1; shift
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34699') # TODO: merge
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34686')
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34662')
    ref+=('https://jenkins.opencord.org/view/vip/job/build_berlin-community-pod-2-gpon-zyxel_1T8GEM_DT_voltha_master/498/console')

    ref+=('https://jenkins.opencord.org/job/ci-management-jjb-merge')
    return
}

__anonymous "$@"
unset __anonymous

# [EOF]
