# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

docs-install:
	pip install mkdocs-material
	pip install --requirement .github/workflows/requirements.txt

docs-serve:
	mkdocs serve

docs-serve-live:
	mkdocs serve --livereload -w ./

docs-build:
	mkdocs build

docs-uninstall:
	pip uninstall mkdocs-material mkdocs -y
	pip uninstall -r .github/workflows/requirements.txt -y

update-build-script:
	gomplate -c build.yaml -f build.tmpl -o build.sh

update-gitlab-ci:
	gomplate -c build.yaml -f build-ci.tmpl -o .gitlab-ci.yml
