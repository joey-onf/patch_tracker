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



    # urls+=('https://jenkins.opencord.org/job/onos-app-release/')
    # urls+=('https://gerrit.opencord.org/c/infra-docs/+/34846')
    
    # urls+=('https://jenkins.opencord.org/job/verify_voltha-docker-tools_unit-test/48/console')
    
    ## ONOS: sadis job
    # urls+=('https://jenkins.opencord.org/job/onos-app-release/291/consoleText')
    # urls+=('https://jenkins.opencord.org/job/onos-app-release/')
    
    urls+=('https://gerrit.opencord.org/q/owner:do-not-reply%2540opennetworking.org')
    
    urls+=('https://mvnrepository.com/artifact/org.opencord/sadis')
    
    ## Publish onos components
    urls+=('https://oss.sonatype.org/#stagingRepositories')

    
    return
}

# [EOF]
