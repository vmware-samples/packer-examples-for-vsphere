#!/bin/bash

set -euo pipefail

dependabot_file=.github/dependabot.yml

# Get a list of Terraform examples.
all_terraform_examples=`find . -type f -name '*.tf' | sed 's#/[^/]*$##' | sed 's/.\///'| sort | uniq`

# Write the dependabot configuation file.
echo "Writing .github/dependabot.yml configuration file..."
cat > $dependabot_file << EOL
# This file is auto-generated. Do not manually amend the configuration.
# https://github.com/vmware-samples/packer-examples-for-vsphere/blob/main/.github/generate-dependabot.sh
#
version: 2
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "daily"
  # Dependabot does not currently support wildcard or multiple directory declarations.
  # https://github.com/dependabot/dependabot-core/issues/2178
EOL

for example in $all_terraform_examples
do
echo "Adding an entry for ${example}."
echo "  - package-ecosystem: \"terraform\"" >> $dependabot_file
echo "    directory: \"/${example}\"" >> $dependabot_file
echo "    schedule:" >> $dependabot_file
echo "      interval: \"daily\"" >> $dependabot_file
done
echo "Done."
