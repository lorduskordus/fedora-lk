#!/usr/bin/env bash

# Changes priority for GPUs, so that DEs prefer using the integrated GPU

set -euo pipefail

FILE_DIR="/usr/share/glvnd/egl_vendor.d"
FILENAME_ORIG="10_nvidia.json"
FILENAME_NEW="90_nvidia.json"

echo "Changing GPU priority"
if [ -f "${FILE_DIR}/${FILENAME_ORIG}" ]; then
    if mv "${FILE_DIR}/${FILENAME_ORIG}" "${FILE_DIR}/${FILENAME_NEW}" &> /dev/null; then
        echo "- Successfully changed priority"
    else
        echo "- Failed to change priority"
        exit 1
    fi
else
    echo "- Could not find the file '"${FILE_DIR}/${FILENAME_ORIG}"'"
    exit 1
fi
