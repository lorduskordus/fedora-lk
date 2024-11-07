# Install all packages from Brewfile
install-brew-cli:
    #!/usr/bin/env bash

    BREWFILE_PATH="/etc/brew/cli.Brewfile"

    export HOMEBREW_BUNDLE_NO_LOCKFILE_WRITE_WARNING=1
    brew bundle install --file "${BREWFILE_PATH}"

# Remove all brew packages
remove-brew-all-packages:
    #!/usr/bin/env bash
    brew remove --force $(brew list --formula) --ignore-dependencies
