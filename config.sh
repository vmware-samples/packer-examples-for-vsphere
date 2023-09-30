#!/usr/bin/env sh
# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

set -e

follow_link() {
	FILE="$1"
	while [ -h "$FILE" ]; do
		# On macOS, readlink -f doesn't work.
		FILE="$(readlink "$FILE")"
	done
	echo "$FILE"
}

SCRIPT_PATH=$(realpath "$(dirname "$(follow_link "$0")")")
CONFIG_PATH=${1:-${SCRIPT_PATH}/config}

mkdir -p "$CONFIG_PATH"
### Copy the example input variables.
echo
echo "> Copying the example input variables..."
cp -av "$SCRIPT_PATH"/builds/*.pkrvars.hcl.example "$CONFIG_PATH"

### Rename the example input variables.
echo
echo "> Renaming the example input variables..."
srcext=".pkrvars.hcl.example"
dstext=".pkrvars.hcl"

for f in "$CONFIG_PATH"/*"${srcext}"; do
	bname="${f%"${srcext}"}"
	echo "${bname}{${srcext} → ${dstext}}"
	mv "${f}" "${bname}${dstext}"
done

echo
echo "> Done."
