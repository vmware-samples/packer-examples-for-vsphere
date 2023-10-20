# Copyright 2023 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install additional packages unavailable in the base image or as a feature.
# Note: Unable to be installed used the "postCreateCommand" option.
RUN apt-get update && \
    apt-get install -y jq xorriso whois && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
