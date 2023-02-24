#!/usr/bin/env bash
set -ex

apt -y install xdg-utils
wget https://github.com/jupyterlab/jupyterlab-desktop/releases/latest/download/JupyterLab-Setup-Debian.deb
dpkg -i JupyterLab-Setup-Debian.deb
rm JupyterLab-Setup-Debian.deb
sed -i 's#/opt/JupyterLab/jupyterlab-desktop#/opt/JupyterLab/jupyterlab-desktop --no-sandbox --disable-setuid-sandbox#' /usr/share/applications/jupyterlab-desktop.desktop
cp /usr/share/applications/jupyterlab-desktop.desktop $HOME/Desktop
chmod +x $HOME/Desktop
cp /dockerstartup/install/jupyterlab_desktop_settings.json $HOME/.config/jupyterlab-desktop/settings.json
