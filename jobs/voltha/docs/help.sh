#!/bin/bash
## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------
function voltha_docs_help()
{
    cat <<EOH
Usage: $0
  --voltha-docs
  --voltha-docs-daily                Todo list
  --voltha-docs-verify               Patch merged, verify rendered results.
EOH
}

# [EOF]
