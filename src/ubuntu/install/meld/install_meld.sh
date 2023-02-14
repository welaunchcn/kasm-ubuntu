#!/usr/bin/env bash
set -ex

apt -y install meld
cp /usr/share/applications/org.gnome.meld.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/org.gnome.meld.desktop
