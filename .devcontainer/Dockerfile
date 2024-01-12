# Copyright 2023-2024 Broadcom. All Rights Reserved.
# SPDX-License-Identifier: BSD-2

FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install additional packages unavailable in the base image or as a feature.
# Note: Unable to be installed used the "postCreateCommand" option.
RUN apt-get update && \
    apt-get install -y jq xorriso whois && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
