#!/usr/bin/env bash

# Intel's power_save causes audio popping
#   - It has to be disabled in a kernel module argument.
#     Currently, it is done with [/etc/modprobe.d/alsa-disable-power-save.conf]
#
#   - Tuned profiles can alter the power_save state.
#     This script sets timeout=0 to [audio] blocks on all Tuned profiles, that
#     have them, mimicking the above.
#     If the whole block is removed instead, it breaks D3Cold nvidia states
#     for some reason.

set -euo pipefail

echo "Editing [audio] blocks on all Tuned profiles"

if ! rpm -q tuned &> /dev/null; then
    echo "- Package Tuned is not installed, skipping."
    exit 0;
fi

TUNED_DIR="/usr/lib/tuned/profiles"
if [[ ! -d "$TUNED_DIR" ]]; then
    echo "- Could not find the directory: '$TUNED_DIR'"
    exit 1
fi

PROFILES=$(grep -rl "\[audio\]" "$TUNED_DIR")
if [[ -z "$PROFILES" ]]; then
    echo "- No profiles with [audio] blocks found in directory: '$TUNED_DIR'"
    exit 1
fi

for profile in $PROFILES; do
    #sed -i '/\[audio\]/,/^$/{d}' "$profile"                        # Removes whole block
    sed -i '/\[audio\]/,/\[/{s/timeout=10/timeout=0/}' "$profile"   # Sets timeout=0
    echo "- Edited profile: '$profile'"
done
