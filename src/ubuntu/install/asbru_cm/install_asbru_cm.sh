#!/usr/bin/env bash
set -ex

wget https://dl.cloudsmith.io/public/asbru-cm/release/cfg/setup/bash.deb.sh
bash bash.deb.sh 
rm bash.deb.sh
apt update
apt -y install asbru-cm
cp /usr/share/applications/asbru-cm.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/asbru-cm.desktop
