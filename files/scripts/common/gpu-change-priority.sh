#!/usr/bin/env bash

# Changes priority for GPUs, so that DEs prefer using the integrated GPU

set -euo pipefail

FILE_DIR="/usr/share/glvnd/egl_vendor.d"
FILE_ORIG="${FILE_DIR}/10_nvidia.json"
FILE_NEW="${FILE_DIR}/90_nvidia.json"

echo "Changing GPU priority"
if [ -f "${FILE_ORIG}" ]; then
    echo "- Found the file '"${FILE_ORIG}"'"
    
    echo "- Moving it to '"${FILE_NEW}"'"
    if mv "${FILE_ORIG}" "${FILE_NEW}" &> /dev/null; then
        echo "- Successfully changed priority"
    else
        echo "- Failed to change priority"
        exit 1
    fi
else
    echo "- Could not find the file '"${FILE_ORIG}"'"
    exit 1
fi
