#!/usr/bin/env sh
# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

set -e

follow_link() {
    FILE="${1}"
    while [ -h "${FILE}" ]; do
        # On macOS, readlink -f doesn't work.
        FILE="$(readlink "${FILE}")"
    done
    echo "${FILE}"
}

# Define the script and config paths
follow_link_result=$(follow_link "$0")
if ! SCRIPT_PATH=$(realpath "$(dirname "${follow_link_result}")"); then
    echo "Error: follow_link or realpath failed"
    exit 1
fi
CONFIG_PATH=${1:-${SCRIPT_PATH}/config}

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
    mv -- "${file}" "${file%.example}"
done

echo
echo "> Done."