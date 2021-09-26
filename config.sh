#!/usr/bin/env sh

set -e

follow_link() {
  FILE="$1"
  while [ -h "$FILE" ]; do
    # On Mac OS, readlink -f doesn't work.
    FILE="$(readlink "$FILE")"
  done
  echo "$FILE"
}

SCRIPT_PATH=$(realpath "$(dirname "$(follow_link "$0")")")
CONFIG_PATH=${1:-${SCRIPT_PATH}/config}

mkdir -p "$CONFIG_PATH"
echo
echo "> Copy default builds configuration"
cp -av "$SCRIPT_PATH"/builds/*.pkrvars.hcl "$CONFIG_PATH"
