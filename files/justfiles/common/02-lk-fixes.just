# Creates local 'brave-browser.desktop' file with the right arguments
setup-brave-hw-decoding:
    #!/usr/bin/env bash

    APP_NAME=brave-browser
    DESKTOP_SRC="/usr/share/applications/$APP_NAME.desktop"
    DIR_DST="$HOME/.local/share/applications"
    DESKTOP_DST="$DIR_DST/$APP_NAME.desktop"

    if [[ -f "$DESKTOP_SRC" ]]; then
        echo "Desktop file '$DESKTOP_SRC' found."
    else
        echo "Desktop file '$DESKTOP_SRC' not found!"
        echo "Application '$APP_NAME' needs to be installed as RPM package."
        exit 1
    fi

    mkdir -p "$DIR_DST"
    cp "$DESKTOP_SRC" "$DESKTOP_DST"

    if [[ -f "$DESKTOP_DST" ]]; then
        echo "Copied to '$DESKTOP_DST' successfully."
    else
        echo "Failed to copy the .desktop file."
        exit 1
    fi

    if sed -i '/^Exec=/ s/$/ --ozone-platform-hint=auto --enable-features=VaapiVideoDecodeLinuxGL,TouchpadOverscrollHistoryNavigation --use-gl=angle --use-angle=gl/' "$DESKTOP_DST"; then
        echo "Updated '$DESKTOP_DST' successfully."
        echo
        echo "Wayland was also set up, but only for this newly created .desktop file. If not already set, go to 'brave://flags/#ozone-platform-hint' and set it to 'auto', so that anything launched outside of this .desktop file uses Wayland as well."
    else
        echo "Failed to update '$DESKTOP_DST'."
        exit 1
    fi

# Creates local 'unityhub.desktop' file that starts Unity on NVIDIA
setup-unity-nvidia:
    #!/usr/bin/env bash

    APP_NAME=unityhub
    DESKTOP_SRC="/usr/share/applications/$APP_NAME.desktop"
    DIR_DST="$HOME/.local/share/applications"
    DESKTOP_DST="$DIR_DST/$APP_NAME.desktop"

    if [[ -f "$DESKTOP_SRC" ]]; then
        echo "Desktop file '$DESKTOP_SRC' found."
    else
        echo "Desktop file '$DESKTOP_SRC' not found!"
        echo "Application '$APP_NAME' needs to be installed as an RPM package."
        exit 1
    fi

    mkdir -p "$DIR_DST"
    cp "$DESKTOP_SRC" "$DESKTOP_DST"

    if [[ -f "$DESKTOP_DST" ]]; then
        echo "Copied to '$DESKTOP_DST' successfully."
    else
        echo "Failed to copy the .desktop file."
        exit 1
    fi

    # Command to replace the "Exec=" line
    if sed -i 's|^Exec=.*|Exec=/bin/sh -l -c '\''__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia /opt/unityhub/unityhub'\'' %U|' "$DESKTOP_DST"; then
        echo "Updated '$DESKTOP_DST' successfully."
    else
        echo "Failed to update '$DESKTOP_DST'."
        exit 1
    fi
