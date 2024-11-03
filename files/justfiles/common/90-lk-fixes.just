# Creates local 'brave-browser.desktop' file with the right arguments & updates any existing PWAs
setup-brave-hw-decoding:
    #!/usr/bin/env bash

    APP_NAME=brave-browser
    DIR_DST="$HOME/.local/share/applications"
    DESKTOP_DST="$DIR_DST/$APP_NAME.desktop"

    DESKTOP_SRC="/usr/share/applications/$APP_NAME.desktop"

    OPTIONS="--ozone-platform-hint=auto --enable-features=VaapiVideoDecodeLinuxGL,TouchpadOverscrollHistoryNavigation --use-gl=angle --use-angle=gl"

    if [[ ! -f "$DESKTOP_DST" ]]; then
        if [[ -f "$DESKTOP_SRC" ]]; then
            echo "Found '$DESKTOP_SRC' desktop file."
        else
            echo "Desktop file '$DESKTOP_SRC' not found!"
            echo "Application '$APP_NAME' needs to be installed as an RPM package."
            exit 1
        fi

        mkdir -p "$DIR_DST"
        cp "$DESKTOP_SRC" "$DIR_DST"

        if [[ -f "$DESKTOP_DST" ]]; then
            echo "Copied to '$DESKTOP_DST' successfully."
        else
            echo "Failed to copy the .desktop file."
            exit 1
        fi
    fi

    for DESKTOP_FILE in "$DIR_DST"/brave-*.desktop; do
        if [[ -f "$DESKTOP_FILE" ]]; then

            DESKTOP_NAME=$(grep -m1 "^Name=" "$DESKTOP_FILE" | cut -d= -f2)

            if ! grep -q -- "$OPTIONS" "$DESKTOP_FILE"; then
                if sed -i "/^Exec=/ s/$/ $OPTIONS/" "$DESKTOP_FILE"; then
                    echo "Updated '$DESKTOP_NAME' successfully."
                else
                    echo "Failed to update '$DESKTOP_NAME'."
                    exit 1
                fi
            else
                echo "Skipped '$DESKTOP_NAME' it is already updated."
            fi
        fi

    done

    echo
    echo "Wayland was also set up, but only for the modified .desktop files. If not already set, go to 'brave://flags/#ozone-platform-hint' and set it to 'auto' to ensure Wayland is used for any Brave browser instance launched outside of these .desktop files."

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
