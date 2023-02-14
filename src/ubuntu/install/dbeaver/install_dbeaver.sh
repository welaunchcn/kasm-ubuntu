#!/usr/bin/env bash
set -ex

wget https://dbeaver.io/debs/dbeaver.gpg.key && gpg --dearmor -o /etc/apt/trusted.gpg.d/dbeaver.gpg dbeaver.gpg.key && rm dbeaver.gpg.key
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | tee /etc/apt/sources.list.d/dbeaver.list
apt update
apt -y install dbeaver-ce
cp dbeaver-ce.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/dbeaver-ce.desktop
