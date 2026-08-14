#!/bin/bash
set -e
set -x

export DEBIAN_FRONTEND=noninteractive

#Install GH cli tool
GH=$(type -p 'gh' || true)
if [ -z "${GH}" ]; then
    echo -e "\033[0;35m###  Installing gh ###\033[0m"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    ARCH=$(dpkg --print-architecture)
    echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |
        tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    apt-get -qq update
    apt-get -qq install gh
    GH=$(type -p 'gh' || true)
else
    apt-get -qq update
fi

apt-get install -y --no-install-recommends \
    shellcheck \
    build-essential \
    docker-compose-v2 \
    pipx \
    python-is-python3 \
    python3-yaml \
    python3-venv \
    npm \
    s3cmd \
    yamllint

rm -rf /var/lib/apt/lists/*
