# Add yourself to groups
groups ACTION="prompt":
    #!/usr/bin/env bash
    source /usr/lib/ujust/ujust.sh

    add_to_group () {
        app="$1"
        if command -v $app &> /dev/null; then
            if grep -E "^${APPS[$app]}:" /usr/lib/group 2> /dev/null | sudo tee -a /etc/group 2> /dev/null && sudo usermod -aG "${APPS[$app]}" "${USER}" 2> /dev/null; then
                echo "App: '${bold}$app${normal}'"
                echo "  - User '${bold}${USER}${normal}' added to group '${bold}${APPS[$app]}${normal}'"
            else
                echo "App: '${bold}$app${normal}'"
                echo "  - Failed adding to group '${bold}${APPS[$app]}${normal}'"
            fi
        else
            echo "App: '${bold}$app${normal}'"
            echo "  - Not a valid option"
            echo "    - Options: ${bold}${APP_OPTIONS}${normal}"
        fi
    }

    # Associative Array - ["APP"]="APP_GROUP"
    declare -A APPS
    APPS["wireshark"]="wireshark"
    APPS["virt-manager"]="libvirt"
    APPS["docker"]="docker"
    APPS["virtualbox"]="vboxusers"

    for app in "${!APPS[@]}"; do
        if command -v $app &> /dev/null; then
            APP_OPTIONS+="${app} "
        fi
    done

    if [ -z "${APP_OPTIONS}" ]; then
        echo "No application this script knows about is installed."
        exit 1
    fi

    OPTION={{ ACTION }}
    if [ "$OPTION" == "prompt" ]; then
        OPTION=$(ugum choose "all" ${APP_OPTIONS})
    fi

    if [ "$OPTION" == "all" ]; then
        for app in ${APP_OPTIONS}; do
            add_to_group "$app"
        done
    elif [ -n "${OPTION}" ]; then
        add_to_group "${OPTION}"
    else
        echo "No changes applied."
        exit 0
    fi
