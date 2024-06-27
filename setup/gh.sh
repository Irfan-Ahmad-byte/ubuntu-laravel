#!/bin/bash

set -e  # Exit on any error
set -x  # Print commands and their arguments as they are executed

apt update

apt install -y git

(type -p wget >/dev/null || (apt update && apt-get install wget -y)) \
&& mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install -y gh

if [ -n "$GIT_USERNAME" ] && [ -n "$GIT_EMAIL" ] && [ -n "$GITHUB_TOKEN" ]; then
    git config --global user.name "$GIT_USERNAME"
    git config --global user.email "$GIT_EMAIL"
    echo "$GITHUB_TOKEN" | gh auth login --with-token
    gh auth setup-git
    git config --global credential.helper store
    echo "https://$GIT_USERNAME:$GITHUB_TOKEN@github.com" > ~/.git-credentials
fi

exec "$@"
