#!/usr/bin/env bash

# Downloads podman-host from 89luca89 that allows using distrobox containers in VS Code.

set -euo pipefail

curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/extras/podman-host -o /usr/bin/podman-host
chmod +x /usr/bin/podman-host
