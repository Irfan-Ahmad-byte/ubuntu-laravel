#!/bin/bash

set -e  # Exit on any error
set -x  # Print commands and their arguments as they are executed

apt-get update

apt-get install -y git

wget https://github.com/cli/cli/releases/download/v2.52.0/gh_2.52.0_linux_amd64.deb
dpkg -i gh_2.52.0_linux_amd64.deb

source ~/.bashrc


if [ -n "$GIT_USERNAME" ] && [ -n "$GIT_EMAIL" ]; then
    git config --global user.name "$GIT_USERNAME"
    git config --global user.email "$GIT_EMAIL"

    # echo "https://$GIT_USERNAME:$GITHUB_TOKEN@github.com" > ~/.git-credentials
fi

exec "$@"
