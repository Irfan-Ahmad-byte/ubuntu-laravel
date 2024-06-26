#!/bin/bash

set -e  # Exit on any error
set -x  # Print commands and their arguments as they are executed

sudo apt update

sudo apt install git

(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

#!/bin/bash

# Set Git config based on passed arguments
if [ -n "$GIT_USERNAME" ] && [ -n "$GIT_EMAIL" ] && [ -n "$GITHUB_TOKEN" ]; then
    git config --global user.name "$GIT_USERNAME"
    git config --global user.email "$GIT_EMAIL"
    gh auth login --with-token "$GITHUB_TOKEN"
    gh auth setup-git
    git config --global credential.helper store
    echo "https://$GIT_USERNAME:$GITHUB_TOKEN@github.com" > ~/.git-credentials
fi

exec "$@"
