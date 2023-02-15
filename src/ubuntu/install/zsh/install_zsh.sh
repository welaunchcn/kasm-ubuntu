#!/usr/bin/env bash
set -ex

apt -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
chsh -s $(which zsh)
