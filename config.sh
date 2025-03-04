#!/usr/bin/env sh
# © Broadcom. All Rights Reserved.
# The term “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-2-Clause

set -e

follow_link() {
    file="$1"
    while [ -h "${file}" ]; do
        file="$(readlink "${file}")"
    done
    printf '%s\n' "${file}"
}

show_help() {
    exit_after="${1:-exit}"
    script_name="$(basename "$0")"

    printf '\033[0;32m Usage\033[0m: %s [Options] [Path]\n\n' "${script_name}"
    printf '\033[0;34m Options:\033[0m\n'
    printf '\033[0;34m --help, -h, -H\033[0m    Display this help message.\n\n'
    printf '\033[0;34m Path:\033[0m             Path to save the generated configuration files. \033[0;34m(Optional)\033[0m\n'
    printf '                   Default: \033[0;34m./config\033[0m.\n\n'

    if [ -z "${input}" ]; then
        if [ "${exit_after}" = "exit" ]; then
        exit 0
        fi
    fi
    read -p "Press Enter to continue..."
}

# Determine script directory
script_path="$(dirname "$(follow_link "$0")")"

# Determine config path
config_path="${1:-${script_path}/config}"

# Handle help options
if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$1" = "-H" ]; then
  show_help
  exit 0
fi

# Ensure config path exists
mkdir -p "${config_path}"

# Copy and rename example files
echo "> Copying and renaming example input variables..."

# Check if files exist before copying
for file in "${script_path}/builds/"*.pkrvars.hcl.example; do
    dst_file="${config_path}/$(basename "${file}")"
    if [ -f "${dst_file}" ]; then
        read -p "File '${dst_file}' already exists. Overwrite? (y/n): " confirm
        if [ "${confirm}" != "y" ]; then
        echo "Skipping '${dst_file}'"
        continue
        fi
    fi
    cp -av "${file}" "${config_path}/"
done

find "${script_path}/builds/" -type f -name "*.pkrvars.hcl.example" -print0 |
    while IFS= read -r -d $'\0' srcfile; do
        srcdir="$(dirname "${srcfile}")"
        dstfile="$(basename "${srcdir}")-$(basename "${srcfile}" .example)"
        dst_file="${config_path}/${dstfile}"
        if [ -f "${dst_file}" ]; then
        read -p "File '${dst_file}' already exists. Overwrite? (y/n): " confirm
            if [ "${confirm}" != "y" ]; then
                echo "Skipping '${dst_file}'"
                continue
            fi
        fi
        cp -av "${srcfile}" "${config_path}/${dstfile}"
    done

echo "> Done."
