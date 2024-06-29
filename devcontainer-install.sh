#!/usr/bin/env bash

# This script is inspired by the remote-install.sh script in webpro's dotfiles
# repository.

set -euxo pipefail

# Install vim and silversearcher.
sudo apt-get update && \
    sudo apt-get -y install --no-install-recommends \
    vim \
    silversearcher-ag

SOURCE="https://github.com/tanayamitshah/dotfiles"
TARGET="$HOME/.dotfiles"

is_executable() {
  type "$1" > /dev/null 2>&1
}

if is_executable "git"; then
  CMD="git clone $SOURCE $TARGET"
fi

if [ -z "$CMD" ]; then
  echo "No git available. Aborting."
else
  echo "Installing dotfiles..."
  mkdir -p "$TARGET"
  eval "$CMD"

  echo "" >> $HOME/.bashrc && cat "$TARGET/.bashrc" >> $HOME/.bashrc
fi
