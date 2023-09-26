# Copyright 2023 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install additional packages unavailable in the base image or as a feature.
# Note: Unable to be installed used the "postCreateCommand" option.
RUN apt update && \
    apt install -y jq xorriso whois && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
