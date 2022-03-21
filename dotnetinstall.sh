#!/bin/bash
apt-get update
apt-get install -y --no-install-recommends \
        git \
        curl \
        wget

cd ~
wget https://download.visualstudio.microsoft.com/download/pr/807f9d72-4940-4b1a-aa4a-8dbb0f73f5d7/cb666c22a87bf9413f29615e0ba94500/dotnet-sdk-6.0.200-linux-x64.tar.gz

mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-6.0.200-linux-x64.tar.gz -C $HOME/dotnet

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

dotnet tool install -g Microsoft.Crank.Controller --version "0.2.0-*"
dotnet tool install -g Microsoft.Crank.Agent --version "0.2.0-*"

cat << \EOF >> ~/.bashrc
# Add .NET Core SDK tools
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
export PATH="$PATH:/root/.dotnet/tools"
EOF
source ~/.bashrc
echo " Dotnet and tools installed successfully"
