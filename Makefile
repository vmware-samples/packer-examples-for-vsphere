# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

.PHONY: docs-install docs-serve docs-serve-live docs-build docs-uninstall
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

.PHONY: update-gitlab-ci

update-gitlab-ci:
	gomplate -c build-ci.yaml -f build-ci.tmpl -o .gitlab-ci.yml
