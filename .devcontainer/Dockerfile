FROM mcr.microsoft.com/devcontainers/base:jammy

# add extra/missing packages
RUN apt update && \
    apt install -y jq xorriso whois && \
    apt autoremove
