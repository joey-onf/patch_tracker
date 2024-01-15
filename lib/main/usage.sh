# -*- sh -*-
## -----------------------------------------------------------------------
## Intent: Context specific arguments for a cx-{topic}-{action}
## -----------------------------------------------------------------------

[[ -v DEBUG ]] && echo "[${BASH_SOURCE[0]##*/}] BEGIN"

## -----------------------------------------------------------------------
## Intent: Load infra modules
## -----------------------------------------------------------------------
function show_usage_header()
{
    cat <<EOH
Usage: $0 
EOH
   return
}

## -----------------------------------------------------------------------
## Intent: Load infra modules
## -----------------------------------------------------------------------
function show_usage_actions()
{
    cat <<EOH

[ACTIONS]
  --create             Create a new topic
  --edit [topic]       Load sources into an editor
  --gerrit             View gerrit dashboard
  --grep               Search for a setring in job.sh source
EOH
   return
}

## -----------------------------------------------------------------------
## Intent: Load infra modules
## -----------------------------------------------------------------------
function show_usage_topic()
{
    local dir="$1"; shift
    [[ $# -gt 0 ]] && local _stem="$1"; shift
    [[ $# -gt 0 ]] && local _subdir="$1"; shift

    pushd "$dir" >/dev/null
    if [[ -v _subdir ]]; then
        readarray -t sources< <(find "${_stem}/${_subdir[@]}" -name '*.sh' -print | sort)
    else
        readarray -t sources< <(find "${_stem}" -name '*.sh' -print | sort)
    fi
    popd >/dev/null

    for source in "${sources[@]}";
    do
        case "$source" in
            */help.sh) continue ;;
            */include.sh) continue;;
            *.sh) ;;
            *) continue ;;
        esac
        name="${source//\//-}"
        name="${name%.sh}" # remove extension
        printf '  --%-40.40s\n' "$name"
    done

    return
}

## -----------------------------------------------------------------------
## Intent: Load infra modules
## -----------------------------------------------------------------------
function show_topic_all()
{
    local dir="$1"; shift

    echo
    echo '[TOPICS]'
    readarray -t sources< <(cd "$dir" \
        ; find '.' -mindepth 1 -maxdepth 1 -type d -print | sort)

    for source in "${sources[@]}";
    do
        name="${source:2}"
        printf '  --%-40.40s\n' "$name"
    done

    return
}

## -----------------------------------------------------------------------
## Intent: Show legacy command line switches for topics.
## Replaced by: show_topic_all()
## -----------------------------------------------------------------------
function show_topic_static()
{ 
    echo
    echo '[TOPICS]'
    cat <<EOH
  --active             Load latest set of jira tickets
  --bbsim              View bbsim test jobs
  --bisdn              Contractor tickets
  --followup           Load followup.sh urls
  --jjb                Branch creation patches
  --make               onf-make makefiles/ patch
  --onos
  --periodic-dt
  --periodic-software
  --up                 Software update
  --vip                Load pipeline vip view
EOH
    return
}

## -----------------------------------------------------------------------
## Intent: Load infra modules
## -----------------------------------------------------------------------
function show_usage_examples()
{
    cat <<EOH

[EXAMPLES]
  % jobs.sh --create make/foo/bar/tans  (tans.sh)
  % jobs.sh --edit make/foo/bar/tans
EOH
    return
}

## -----------------------------------------------------------------------
## Intent: Load infra modules
## -----------------------------------------------------------------------
function show_usage_modes()
{
    cat <<EOH

[MODE]
  --edit [a][b][c]     Edit tool sources by topic name
  --edit voltha-docs-daily
EOH
    return
}

## -----------------------------------------------------------------------
## Intent: Usage API
## Given:
##   --header           Display program header
##   --topic            Display topic specific help (--make-help)
##   --examples         Display usable comamnd line switches
## -----------------------------------------------------------------------
function usage()
{
    local arg
    while [[ $# -gt 0 ]]; do
        arg=$1; shift
        case "$arg" in

            --help)
                local -a args=()
                args+=('--examples')
                args+=('--header')
                args+=('--modes')
                args+=('--topics')
                set -- "${args[@]}" "$@"
                local -i show_help=1
                ;;

            --examples) declare -i arg_examples=1 ;;
            --header)   declare -a arg_header=1 ;;
            --modes)    declare -a arg_modes=1 ;;
            --topics)   declare -a arg_topics=1 ;;
            
            --topic)
                local dir="$1"; shift
                show_usage_topic "$dir" "$stem"
                ;;
        esac
    done

    [[ -v arg_header ]] && { show_usage_header; }
    
    if [[ -v show_help ]]; then

        [[ -v arg_topics ]] && { show_topic_all "$pgmroot/jobs/jobs"; }
        [[ -v arg_topics_static ]] && { show_topic_static "$pgmroot/jobs/jobs"; }

    [[ -v arg_actions ]] && { show_usage_actions; }
        
    cat <<EOH

[INFRA]
  --infra-jenkins      VOLTHA jenkins todo
EOH

    [[ -v arg_modes ]] && { show_usage_modes; }

    cat <<EOH

[CLEANUP]
  --lint               Cleanup linting complaints

  --helm               vars/helmTearDown.sh
  --merge              Reviewed, pending merge jobs.

  --mahir
  --nikesh 
  --voltha-stack       Patch volthaStackDeploy
  --voltha-system-tests
  --gerrit             Gerrit dashboard
  --epics              BBSIM and Release epics
EOH

    fi

    [[ -v arg_examples ]] && { show_usage_examples; }

    return
}

# __anonymous $@
# unset __anonymous

[[ -v DEBUG ]] && echo "[${BASH_SOURCE[0]##*/}] END"

# [EOF]
