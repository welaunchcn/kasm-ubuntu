#!/usr/bin/env bash
set -ex

wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt update
# dotnet core rt: https://github.com/dotnet/corert/blob/master/Documentation/prerequisites-for-building.md
apt -y install dotnet-sdk-6.0 llvm cmake clang libicu-dev uuid-dev libcurl4-openssl-dev zlib1g-dev libkrb5-dev libtinfo5
