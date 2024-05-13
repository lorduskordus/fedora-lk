#!/usr/bin/env bash

# Clones gnome-shell from GitLab & compiles the theme with a custom accent.

set -oue pipefail

# Setup variables
THEME_NAME_LIGHT="gnome-shell-custom-image-light"
THEME_NAME_DARK="gnome-shell-custom-image-dark"
ACCENT_FILE="${CONFIG_DIRECTORY}/files/gnome/usr/etc/skel/.config/gtk-4.0/gtk.css"
ACCENT_COLOR_LIGHT=$(awk '/@define-color accent_bg_color/{ print substr( $3, 1, length($3)-1 ) }' "${ACCENT_FILE}" 2> /dev/null)
ACCENT_COLOR_DARK=$(awk '/@define-color accent_color/{ print substr( $3, 1, length($3)-1 ) }' "${ACCENT_FILE}" 2> /dev/null)
THEME_PATH="/usr/share/themes"
SHELL_VERSION="$(gnome-shell --version | awk '{print $3}')"
WORKDIR="/tmp/gnome-shell"
SASSC_BIN="${CONFIG_DIRECTORY}/scripts/sassc"

echo "Creating a gnome-shell theme with a custom accent.."

# Do we have accent color ?
if [ -z "${ACCENT_COLOR_DARK}" ]; then
	echo "Accent color in '${ACCENT_FILE}' is missing. Set a custom accent color first."
	exit 1
fi

# Clone gnome-shell repo to '/tmp'.
git clone --branch ${SHELL_VERSION} "https://gitlab.gnome.org/GNOME/gnome-shell.git" "${WORKDIR}" &> /dev/null
if [ $? -eq 128 ]; then
	echo "Version ${SHELL_VERSION} doesn't exist."
	exit 1
fi

# ---- DARK ---- #

# Set a custom accent color.
sed -i "s|\$blue_3.*|\$blue_3: ${ACCENT_COLOR_DARK};|" "${WORKDIR}/data/theme/gnome-shell-sass/_palette.scss"

# Compile the theme.
${SASSC_BIN} -a "${WORKDIR}/data/theme/gnome-shell-dark.scss" "${WORKDIR}/data/theme/gnome-shell-dark.css"

# Copy the new theme.
mkdir -p "${THEME_PATH}/${THEME_NAME_DARK}/gnome-shell"
cp "${WORKDIR}/data/theme/gnome-shell-dark.css" "${THEME_PATH}/${THEME_NAME_DARK}/gnome-shell/gnome-shell.css"

# ---- LIGHT ---- #

if [ -n "${ACCENT_COLOR_LIGHT}" ]; then
	# Set a custom accent color.
	sed -i "s|\$blue_3.*|\$blue_3: ${ACCENT_COLOR_LIGHT};|" "${WORKDIR}/data/theme/gnome-shell-sass/_palette.scss"

	# Compile the theme.
	${SASSC_BIN} -a "${WORKDIR}/data/theme/gnome-shell-light.scss" "${WORKDIR}/data/theme/gnome-shell-light.css"

	# Copy the new theme.
	mkdir -p "${THEME_PATH}/${THEME_NAME_LIGHT}/gnome-shell"
	cp "${WORKDIR}/data/theme/gnome-shell-light.css" "${THEME_PATH}/${THEME_NAME_LIGHT}/gnome-shell/gnome-shell.css"
fi

# Cleanup.
rm -rf "${WORKDIR}"

echo "Done."