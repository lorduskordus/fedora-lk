# Add yourself to groups
groups ACTION="prompt":
    #!/usr/bin/env bash
    source /usr/lib/ujust/ujust.sh

    add_to_group () {
        app="$1"
        if command -v $app &> /dev/null; then
            grep -E "^${APPS[$app]}:" /usr/lib/group | sudo tee -a /etc/group && sudo usermod -aG "${APPS[$app]}" "${USER}"
            echo "App: '${bold}$app${normal}'"
            echo "  - User '${bold}${USER}${normal}' added to group '${bold}${APPS[$app]}${normal}'"
        else
            echo "App: '${bold}$app${normal}'"
            echo "  - Not installed"
        fi
    }

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

    OPTION={{ ACTION }}
    if [ "$OPTION" == "prompt" ]; then
        OPTION=$(ugum choose "all" ${APP_OPTIONS})
    fi

    if [ "$OPTION" == "all" ]; then
        for app in "${!APPS[@]}"; do
            add_to_group "$app"
        done
    elif [ -n "${OPTION}" ]; then
        add_to_group "${OPTION}"
    else
        echo "No changes applied."
        exit 0
    fi
