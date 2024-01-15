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

    source "$libdir/help.sh"
    source "$libdir/server.sh"
    return
}

__anonymous $@
unset __anonymous

[[ -v DEBUG ]] && echo "[${BASH_SOURCE[0]##*/}] END"

# [EOF]
