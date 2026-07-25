# © Broadcom. All Rights Reserved.
# The term “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-2-Clause

.PHONY: docs-install docs-serve docs-serve-live docs-build docs-uninstall
docs-install:
	pip install --requirement .github/workflows/requirements.txt

docs-serve:
	zensical serve

docs-serve-live:
	zensical serve

docs-build:
	zensical build

docs-uninstall:
	pip uninstall -r .github/workflows/requirements.txt -y

.PHONY: update-gitlab-ci

update-gitlab-ci:
	gomplate -c build-ci.yaml -f build-ci.tmpl -o .gitlab-ci.yml
