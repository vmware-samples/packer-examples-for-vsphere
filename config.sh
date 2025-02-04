#!/usr/bin/env bash
# © Broadcom. All Rights Reserved.
# The term “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-2-Clause

set -e

follow_link() {
    FILE="${1}"
    while [ -h "${FILE}" ]; do
        # On macOS, readlink -f doesn't work.
        FILE="$(readlink "${FILE}")"
    done
    echo "${FILE}"
}

# This function displays the help message.
show_help() {
    local exit_after=${1:-"exit"}
    script_name=$(basename "$0")

    printf "\033[0;32m Usage\033[0m: %s [options] [config_path]\n\n" "$script_name"
    printf "\033[0;34m Options:\033[0m\n"
    printf "  \033[0;34m --help, -h, -H\033[0m       Display this help message.\n\n"
    printf "\033[0;34m config_path:\033[0m\n"
    printf "  \033[0m Path to save the generated configuration files. (Optional).\n\n"

    # Handle user input or exit.
    if [[ -z "$input" ]]; then
        [ "$exit_after" = "exit" ] && exit 0
    else
        press_enter_continue
    fi
}

# Define the script and default config paths
follow_link_result=$(follow_link "$0")
if ! SCRIPT_PATH=$(realpath "$(dirname "${follow_link_result}")"); then
    echo "Error: follow_link or realpath failed"
    exit 1
fi

# Set config_path if it's not already set
if [ -z "$CONFIG_PATH" ]; then
    CONFIG_PATH=$(
        cd "${SCRIPT_PATH}/config" || exit
        pwd
    )
fi

# Script options.
while (("$#")); do
    case "$1" in
    --help | -h | -H)
        run_show_help=true
        show_help
        shift
        ;;
    *)
        CONFIG_PATH=$(realpath "$1")
        shift
        ;;
    esac
done

mkdir -p "${CONFIG_PATH}"
### Copy the example input variables.
echo
echo "> Copying the example input variables..."
cp -av "${SCRIPT_PATH}"/builds/*.pkrvars.hcl.example "${CONFIG_PATH}"
find "${SCRIPT_PATH}"/builds/*/ -type f -name "*.pkrvars.hcl.example" | while IFS= read -r srcfile; do
    srcdir=$(dirname "${srcfile}" | tr -s /)
    dstfile=$(echo "${srcdir#"${SCRIPT_PATH}"/builds/}" | tr '/' '-')
    cp -av "${srcfile}" "${CONFIG_PATH}/${dstfile}.pkrvars.hcl.example"
done

### Rename the example input variables.
echo
echo "> Renaming the example input variables..."
for file in "${CONFIG_PATH}"/*.pkrvars.hcl.example; do
    mv -i -- "${file}" "${file%.example}"
done

echo
echo "> Done."
