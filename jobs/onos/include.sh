# -*- sh -*-
## -----------------------------------------------------------------------
## Intent: Context specific arguments for a cx-{topic}-{action}
## -----------------------------------------------------------------------

[[ -v DEBUG ]] && echo "[${BASH_SOURCE[0]##*/}] BEGIN"

## -----------------------------------------------------------------------
## Intent: Load infra modules
## -----------------------------------------------------------------------
function __anonymous()
{
    local libdir="$(realpath ${BASH_SOURCE[0]%/*})"

    pushd "$libdir" >/dev/null

    local fyl
    readarray -t fyls < <(find . -name '*.sh' -type f -print)
    for fyl in "${fyls[@]}";
    do
        case "$fyl" in
            *include.sh) continue ;;
            *) source "$libdir/$fyl"
    done
    return
}

__anonymous $@
unset __anonymous

[[ -v DEBUG ]] && echo "[${BASH_SOURCE[0]##*/}] END"

# [EOF]
