#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

shopt -s extglob
# set -x

{
    declare -g pgm="$(readlink --canonicalize-existing "$0")"
    declare -g pgmbin="${pgm%/*}"
    declare -g pgmroot="${pgmbin%/*}"
    declare -g pgmname="${pgm%%*/}"

    readonly pgm
    readonly pgmbin
    readonly pgmroot
    readonly pgmname

    declare -g pgmjobs="$pgmbin/jobs"
    readonly pgmjobs
}

##--------------------##
##---]  INCLUDES  [---##
##--------------------##
source "${pgmbin}/lib/main/include.sh"
# source "${pgmbin}/lib/main/usage.sh"

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function create_topic()
{
    local path="$1"; shift

    readarray -d'/' -t fields < <(printf '%s' "$path")
    local -i max=$((${#fields[@]}-1))

#    if [[ ${#fields[@]} -lt 2 ]]; then
    if [[ ${#fields[@]} -lt 1 ]]; then
        error "path=[$path] requires subdirectories"
    fi
    local name="${fields[$max]}"
    fields=("${fields[@]:0:$max}")
    
    path="$(join_by '/' "$pgmjobs" "${fields[@]}")"

    name="${name%.sh}" # remove extension
    name_sh="${name}.sh"

    local funcname="$(join_by '_' "${fields[@]}" "$name")"
    local do_func="do_${funcname}"
    name="${source//\//-}"

    mkdir -p "$path"

    if [[ ! -e "$path/include.sh" ]]; then
        cp "$pgmbin/tmpl/include.sh" "$path"
    fi

    cat <<EOF>> "$path/${name_sh}"
#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function ${do_func}()
{
    local -n ref=\$1; shift

    # ref+=('https://jira.opencord.org/browse/VOL-4805')
    return
}

# [EOF]
EOF

    add2edit "$path/${name_sh}"
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_func()
{
    local -n ref=$1; shift
    local funcname="$1"; shift

    local func="do_${fmt}"
    if is_func "$func"; then
        eval "$func" $ref
    else
        error "Detected invalid function: $func"
    fi
    return
}

## -----------------------------------------------------------------------
## Intent: Determine if the given token is a function name
## -----------------------------------------------------------------------
function is_func()
{
    local arg="$1"; shift

    [[ $# -gt 0 ]] && echo "** $*"
    [[ $(type -t "$arg") == function ]] && { true; } || { false; }
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function squeeze()
{
    local -n ref=$1; shift

    ## FIX HARDCODED REFERENCES
    ## local -n vars were hokey

    local -a _raw=("${ref[@]}")
    local -a squeeze_tmp=()
    local val
    for val in "${_raw[@]}";
    do
        [[ ${#val} -eq 0 ]] && continue
        [[ "$val" =~ ^[[:blank:]]*$ ]] && continue
        squeeze_tmp+=("$val")
    done

    ref=("${squeeze_tmp[@]}")
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_active()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5170')

    # ci-mgmt
    # ref+=('https://gerrit.opencord.org/c/ci-management/+/34646')

    ## Version mismatch
    # code repo
    ref+=('https://gerrit.opencord.org/c/voltha-openolt-adapter/+/34531')

    # jenkins
    ref+=('https://jenkins.opencord.org/job/verify_voltha-openolt-adapter_sanity-test-voltha-2.12')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_alex()
{
    local -n ref=$1; shift
    ref+=('https://wiki.opennetworking.org/pages/viewpage.action?spaceKey=JOEY&title=SMaRT5g')
    return
}	

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_bisdn()
{
    local -n ref=$1; shift
    ref+=('https://jira.opencord.org/browse/VOL-5175')
    return
}	

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_docs()
{
    local -n ref=$1; shift
    echo "No ULRs available"
    return
}	

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_bbsim()
{
    local -n ref=$1; shift

    ref+=('https://jenkins.opencord.org/job/periodic-voltha-test-bbsim')
#    ref+=('https://jenkins.opencord.org/job/periodic-voltha-test-bbsim-master')
    ref+=('https://jenkins.opencord.org/job/periodic-voltha-test-bbsim-2.12')
    ref+=('https://jenkins.opencord.org/job/verify_bbsim_unit-test')

    # software-upgrade-test-bbsim:
    #    /home/jenkins/.kube/kind-config-voltha-minimal
    ref+=('https://jira.opencord.org/browse/VOL-4849')
    
    return
}	

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_epics()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5125')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_lint()
{
    local -n ref=$1; shift

    ref+=('https://gerrit.opencord.org/c/ci-management/+/34738')
    ref+=('https://gerrit.opencord.org/c/onf-make/+/34758')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_lint_shell()
{
    local -n ref=$1; shift

    ref+=('https://gerrit.opencord.org/c/onf-make/+/34747')
    ref+=('https://gerrit.opencord.org/c/onf-make/+/34748')
    ref+=('https://gerrit.opencord.org/c/onf-make/+/34749')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_merge()
{
    local -n ref=$1; shift
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34724')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_olt_active()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5062')
    # ref+=('https://jenkins.opencord.org/job/verify_voltha-openolt-adapter_sanity-test-voltha-2.12')
    ref+=('https://gerrit.opencord.org/c/voltha-openolt-adapter/+/34531') ## ** 

    local val='olt'
    case "$val" in
        1)
            ref+=('https://jira.opencord.org/browse/VOL-5177')
            ref+=('https://jira.opencord.org/browse/VOL-5054')
            ref+=('https://jira.opencord.org/browse/VOL-5170')
            ref+=('https://jenkins.opencord.org/job/verify_voltha-openolt-adapter_sanity-test-voltha-2.12')
            ref+=('https://gerrit.opencord.org/c/ci-management/+/34677')
            ref+=('https://gerrit.opencord.org/c/voltha-openolt-adapter/+/34531')
            ref+=('https://gerrit.opencord.org/c/ci-management/+/34683')
            ;;

        *)
            ref+=('https://gerrit.opencord.org/c/voltha-openolt-adapter/+/34531')
            ref+=('https://jenkins.opencord.org/job/verify_voltha-openolt-adapt')
            ;;
    esac

    ## Version bump in dependencies.xml
    ref+=('https://gerrit.opencord.org/c/voltha-onos/+/34397')
    
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_olt()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5177')
    ## Patch merged, verify
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34739')


    ref+=('https://jira.opencord.org/browse/VOL-5170')
    # jenkins
    ref+=('https://jenkins.opencord.org/job/verify_voltha-openolt-adapter_sanity-test-voltha-2.12')

    ## Check for new review input
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34616')

    ## Verify pkill_port_forward.groovy
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34653')

    # fix installVoltctl
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34654')

    ## Latest installVoltctl patch
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34655')

    
    # ~/.volt/config
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34668')
    
    ref+=('https://gerrit.opencord.org/c/voltha-openolt-adapter/+/34531')

    
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_onf_make()
{
    local -n ref=$1; shift

    ref+=('https://jira.opennetworking.org/browse/INF-780')
    ref+=('https://gerrit.opencord.org/c/onf-make/+/34703')
    ref+=('https://gerrit.opencord.org/c/onf-make/+/34826')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_onos()
{
    local -n ref=$1; shift
    ref+=('https://jira.opencord.org/browse/VOL-4805')
    ref+=('https://jira.opencord.org/browse/VOL-4806')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_patches()
{
    local -n ref=$1; shift
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34622')

    #---]  vars/getVolthaCode.groovy::main  [---#
    # 17:14:34  ** vars/getVolthaCode.groovy::main: EXCEPTION hudson.AbortException: Couldn't find any revision to build. Verify the repository and branch configuration for this job.
    # 17:14:27  Downloading VOLTHA code with the following parameters: [branch:voltha-2.12, gerritProject:voltha-system-tests, gerritRefspec:refs/changes/33/34533/1, volthaSystemTestsChange:, volthaHelmChartsChange:].
    ref+=('https://jenkins.opencord.org/job/verify_voltha-system-tests_sanity-test-voltha-2.12/2/console')

    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_release()
{
    local -n ref=$1; shift
    ref+=('https://jenkins.opencord.org/job/github-release_voltctl')
    return
}

## -----------------------------------------------------------------------
## Intent: Display future enhancements
## -----------------------------------------------------------------------
function show_todo()
{
    cat <<EOM

** ----------------------------------------------------------------------
** ----------------------------------------------------------------------
**  o repo:helm-chart-tools :: check_chart_version.sh -- reindent
EOM

    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_vip()
{
    local -n ref=$1; shift

    [[ $# -eq 0 ]] && set -- 'view'

    while [[ $# -gt 0 ]]; do
        arg="$1"; shift

        case "$arg" in
            view) urls+=('https://jenkins.opencord.org/view/vip') ;;
            jobs)
                ref+=('https://jenkins.opencord.org/job/periodic-voltha-test-bbsim')
                ref+=('https://jenkins.opencord.org/job/periodic-voltha-test-bbsim-2.12')
                ;;
            *) error "Detected invalid job arg --vip-${arg}" ;;
        esac
    done
    
    return
}	

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_voltha_stack()
{
    local -n ref=$1; shift

    ref+=('https://jira.opencord.org/browse/VOL-5180')
    # ref+=('https://gerrit.opencord.org/c/ci-management/+/34701')
    ref+=('https://gerrit.opencord.org/c/ci-management/+/34702')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_voltha_system_tests()
{
    local -n ref=$1; shift

    ref+=('https://gerrit.opencord.org/c/voltha-system-tests/+/34394')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function do_voltha_protos()
{
    local -n ref=$1; shift

    ref+=('https://gerrit.opencord.org/c/voltha-lib-go/+/34776')
    ref+=('https://gerrit.opencord.org/c/bbsim/+/34778')
    ref+=('https://gerrit.opencord.org/c/voltha-docs/+/34915')
    return
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function set_defaults()
{
    declare -n ref=$1; shift

    [[ ${#ref[@]} -gt 0 ]] && { set -- "${ref[@]}"; }
    [ $# -eq 0 ] && { set -- '--default--'; }
    
    case "${ref[@]}" in
        *--browser*) ;;
        *--firefox*) ;;
        *--opera*) ;;
        *) set -- '--browser' 'opera' "$@" ;;
    esac

    ref=("$@")
    return
}

##----------------##
##---]  MAIN  [---##
##----------------##

# banner "$0"

declare -a urls=()
declare -a args_raw=()
if [[ $# -gt 0 ]]; then
    readarray -t -d ' ' args_raw < <(printf '%s ' "$@")
fi

set_defaults args_raw
set -- "${args_raw[@]}"

while [ $# -ne 0 ]; do
    arg="$1"; shift
    
    case "$arg" in

        --jira)
            urls+=('https://jira.opencord.org/browse/VOL-5201')
            ;;
        
        --edit)
            declare -i -g argv_edit=1

            source "${pgmbin}/lib/main/getopt/edit.sh"
            declare -a args=("$@")
            do_edit todo args
            set -- "${args[@]}" # Adjust ARGV for --edit args removed
            ;;
            
        --browser) BROWSER="$1"; shift ;;
        --opera|--firefox) set -- '--browser' "$arg" "$*" ;;

        --create)
            arg="$1"; shift
            create_topic "$arg"
            ;;

	    --debug) declare -g -i debug=1 ;;
        --help)  usage '--help'; exit 0 ;;

	    --default--)
            urls+=('https://gerrit.opencord.org')
            urls+=('https://jenkins.opencord.org')
	        # set -- --bbsim "$@"
	        ;;

    	--active)
            do_active urls
            set -- '--v211'
            ;;
    	--bbsim)   do_bbsim  urls  ;;
    	--bisdn)   do_bisdn  urls  ;;
    	--epics)   do_epics  urls  ;;
        --helm)
            # vars/helmTearDown.groovy
            urls+=('https://gerrit.opencord.org/c/ci-management/+/34723')
            urls+=('https://gerrit.opencord.org/c/ci-management/+/34724')
            ;;

        --onos-orig*) # 2023-10-17
            source "${pgmjobs}/onos/include.sh"
            case "$arg" in
                --onos-infra) do_onos_infra urls ;;
                --onos-help)  onos_help          ;;
                *)
                    onos_help
                    error "Detected invalid --onos switch [$arg]"
                    ;;
            esac
            ;;

        ##------------------------##
        ##---]  jobs-by-user  [---##
        ##------------------------##
        --user-*)
            readarray -d'-' -t fields < <(printf '%s' "${arg:2}")
            user="${fields[1]}"
            path="$pgmjobs/users"
            user_sh="${path}/${user}.sh"

            declare -p fields
            declare -p user
            declare -p user_sh

            
            if [ -f "$user_sh" ]; then
                source "$user_sh" urls
            else
                echo "ERROR: --user switch [$arg] not found, try one of:"
                echo
                find "$path" -mindepth 1 -maxdepth 1 -name '*.sh' -print
            fi
            ;;
#            case "${fields[1]}" in
#	            abhilash)   source "$pgmjobs/users/abhilash.sh" urls ;;
#	            jan)        source "$pgmjobs/users/jan.sh"      urls ;;
#	            mahir)      source "$pgmjobs/users/mahir.sh"    urls ;;
#	            nikesh)     source "$pgmjobs/users/nikesh.sh"   urls ;;
 #           esac
            
#	    --abhilash)   source "$pgmjobs/users/abhilash.sh" urls ;;
#	    --jan)        source "$pgmjobs/users/jan.sh"      urls ;;
#	    --mahir)      source "$pgmjobs/users/mahir.sh"    urls ;;
#	    --nikesh)     source "$pgmjobs/users/nikesh.sh"   urls ;;

        ##------------------------##
        ##------------------------##
        --merge)   do_merge  urls  ;;

  	    --olt)
            # do_olt urls
            do_olt_active urls
            ;;

        --onf-make) do_onf_make urls ;;        

        --lint*)
            case "$arg" in
                --lint-shell) do_lint_shell urls ;;
                *) do_lint urls ;;
            esac
            ;;
            
    	--release) do_release urls ;;
        
	    --docs)    do_docs urls ;;
	    --patches) do_patches urls ;;
        
	    --followup)
	        declare -a todo=()
	        todo+=('periodic-voltha-dt-test-bbsim')
	        ~/projects/followup/bin/followup.sh "${todo[@]}"
	        ;;
        
        --grep)
            arg="$1"; shift
            grep -r "$arg" "$pgmbin"
            ;;
        
	    # --periodic-dt
	    --periodic-dt)
	        urls+=('https://jenkins.opencord.org/view/vip/job/periodic-voltha-dt-test-bbsim-2.12/55/console')
	        # urls+=('https://gerrit.opencord.org/c/ci-management/+/34602')
	        urls+=('https://jenkins.opencord.org/job/ci-management-jjb-merge/')  # 2731
	        urls+=('https://jenkins.opencord.org/job/ci-management-jjb-verify/') # 4228
	        ;;
        
        # -----------------------------------------------------------------------
        # 15:26:46  ++ grep -E -v docker-registry
        # 15:26:56  W0823 19:26:54.991101    3280 loader.go:223] Config not found: /home/jenkins/.kube/kind-config-voltha-minimal
        # 15:26:56  W0823 19:26:54.991360    3280 loader.go:223] Config not found: /home/jenkins/.kube/kind-config-voltha-minimal
        # 15:26:56  Error: Kubernetes cluster unreachable: Get "http://localhost:8080/version?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
        # -----------------------------------------------------------------------
	    --periodic-software)
	        urls+=('https://jenkins.opencord.org/job/periodic-software-upgrade-test-bbsim/')
	        urls+=('https://gerrit.opencord.org/c/ci-management/+/34603') # add installKind.sh
	        ;;
	    
	    --up*)
	        urls+=('https://jenkins.opencord.org/job/periodic-software-upgrade-test-bbsim')
	        ;;

	    --vip)   do_vip  urls 'view' ;;
        --vip-*) do_vip  urls "${arg:6}" ;; # --vip-jobs

        --voltha-ignore-*)
            case "$arg" in
                --voltha-docker-tools)
                    ref+=('https://gerrit.opencord.org/c/voltha-docker-tools/+/34870')
                    ;;
                
                --voltha-api-server)
                    tst+=('https://gerrit.opencord.org/c/voltha-api-server/+/34819') ;;
	            # --voltha-docs)     do_voltha_docs urls   ;;
	            --voltha-protos)   do_voltha_protos urls ;;
	            --voltha-stack)    do_voltha_stack urls  ;;
	            --voltha-system-tests)
                    do_voltha_system_tests urls
                    ;;
                *) error "Detected invalid--voltha- switch [$arg]" ;;
            esac
            ;;

        --todo) show_todo ;;

	## -----------------------------------------------------------------------
        ## --alex
        ## --gerrit
        ## --infra
        ## --jjb
        ## --make
        ## --onos
        ## --recheck
        ## --v211
        ## --web
	## -----------------------------------------------------------------------
        --*)
            case "$arg" in
                --voltha-*)
                    do_continue=1
                    case "$arg" in
                        --voltha-api-server)
                            tst+=('https://gerrit.opencord.org/c/voltha-api-server/+/34819') ;;
	                    # --voltha-docs)     do_voltha_docs urls   ;;
	                    --voltha-protos)   do_voltha_protos urls   ;;
	                    --voltha-stack)    do_voltha_stack urls    ;;
	                    --voltha-system-tests) do_voltha_system_tests urls ;;
                        *) do_continue=0 ;;
                        #$ *) error "Detected invalid--voltha- switch [$arg]" ;;
                    esac
                    [[ $do_continue -eq 1 ]] && continue
                    ;;
            esac

            
            declare arg_deblanked="${arg//[[:blank:]]}"
            readarray -d'-' -t raw < <(printf '%s' "$arg_deblanked")
            squeeze raw
            fields=("${raw[@]}")  ## [HACK] FIX ME!  squeeze() returns ref=

            if [[ ${#fields[@]} -eq 1 ]]; then
                fields+=('help')
            fi

            while [ ${#fields[@]} -gt 1 ]; do
                declare stem="${fields[0]}"
                declare fmt="$(join_by '_' "${fields[@]}")"
                declare include="$(join_by '/' "${pgmjobs}" "${fields[@]}" 'include.sh')"

                # jobs/voltha/docs/foo/include.sh
                if [ -f "$include" ]; then
                    source "$include"
                    fmt="${include}_help" # display topic help
                    break
                fi

                # jobs/voltha/docs/ {foo.sh, include.sh}
                declare -i max=$(( ${#fields[@]} - 1 ))
                declare stem="${fields[$max]}"
                unset fields[$max]
                fields=("${fields[@]}")
                fields_last=("${fields[@]}")

                # [DEBUG]
                # -----------------------------------------------------------------------
                # declare -a args_raw=([0]="--browser" [1]="opera" [2]="--gerrit-help")
                # declare -- val="gerrit"
                # declare -- val="help"
                # declare -a fields=([0]="gerrit" [1]="help")
                # declare -- include_sh="/home/joey/projects/jobs/jobs/gerrit/include.sh"
                # -----------------------------------------------------------------------
                
                # jobs/voltha/docs/foo.sh
                # jobs/gerrit/help.sh
                declare foo_sh="$(join_by '/' "$pgmjobs" "${fields[@]}" "${stem}.sh")"
                if [ -f "$foo_sh" ]; then # --make => make/help.sh
                    source "$foo_sh"
                    declare fmt="$(join_by '_' 'do' "${fields[@]}" "$stem")"
                    func="$fmt"
                    break
                fi

                # jobs/voltha/docs/foo.sh
                declare include_sh="$(join_by '/' "$pgmjobs" "${fields[@]}" 'include.sh')"
                if [ ! -f "$include_sh" ]; then 
                    nothing_to_do "$stem"
                    declare what="$(join_by '/' "${raw[@]}")"
                    
                    echo
                    echo "** NOTE: Create topic using ${0##*/} --create $what"
                    exit 1

                elif [[ "$stem" == 'help' ]]; then
                    declare help_sh="$(join_by '/' "$pgmjobs" "${fields_last[@]}")"
                    declare fmt='library-topic-help'

                else
                    nothing_to_do "$stem"
                    declare what="$(join_by '/' "${raw[@]}")"
                    echo
                    echo "** NOTE: Create topic using ${0##*/} --create $what"
                    exit 1
                fi
            done

            case "$fmt" in
                *_all)
                    readarray -t sources< <(find "${pgmjobs}/${stem}" -name '*.sh' -print)
                    for source in "${sources[@]}";
                    do
                        declare func="do_${fmt}"
                        declare stem="${fields[0]}"
                        # declare -p func
                        # declare -p stem
                        case "$source" in
                            */include.sh) ;;
                            *)  eval "$func" urls ;;
                        esac
                    done
                    urls+=("${source[@]}")
                    ;;

                library-topic-help)
                    if [[ ${#fields[@]} -eq 1 ]]; then
                        stem="${fields[0]}"
                        echo "USAGE: $0"
                        show_usage_topic "$pgmjobs" "$stem"
                    
                    elif [[ ${#fields[@]} -gt 1 ]]; then
                        stem="${fields[0]}"
                        unset fields[0]
                        subdir=("${fields[@]}")
                        echo "USAGE: $0"
                        show_usage_topic "$pgmjobs" "$stem" "$subdir"
                    else
                        error "Unable to construct help path from $(declare -p fields)"
                    fi

                    ;;

                */include.sh_help)
                    path="${fmt/\/include.sh_help/}"
                    # declare -p fmt
                    source "${pgmbin}/lib/main/usage.sh"

                    # TRYING: /home/joey/projects/jobs/jobs/voltha/docs
                    # declare -- dir="/home/joey/projects/jobs/jobs/voltha/docs"
                    # find: ‘voltha’: No such file or directory
                    if true; then
                        # stem= needed by show_usage_topicex
                        usage '--topic' "$path"
                    else
                        usage '--topic' "$pgmjobs"
                    fi
                    continue
                    ;;

                "$stem"|*_help)
                    source "${pgmbin}/lib/main/usage.sh"
                    usage '--topic' "$pgmjobs"
                    continue
                    ;;
                
                *)
                    declare -a url_buffer=()
                    eval "$func" url_buffer
                    if [[ ${#url_buffer[@]} -eq 0 ]]; then
                        nothing_to_do "$arg (func=${func})"
                        # nothing_to_do "${func}()"
                    else
                        urls+=("${url_buffer[@]}")
                    fi
                    # eval "$func" urls
                    ;;
            esac
            ;;

	    -*) echo "[SKIP] unhandled arg $arg" ;;
	    *) urls+=('https://jenkins.opencord.org') ;;
    esac 
done

[[ -v debug ]] && declare -p urls
edit_files

if [[ ${#urls[@]} -gt 0 ]]; then # empty if --help
    declare -a bargs
    bargs+=('--new-window')
    "$BROWSER" "${bargs[@]}" "${urls[@]}" >/dev/null 2>/dev/null &
    # https://superuser.com/questions/731467/command-line-option-to-open-chrome-in-new-window-and-move-focus
fi

# [EOF]
