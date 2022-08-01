#!/bin/bash
apt-get update
apt-get install -y --no-install-recommends \
        git \
        curl \
        wget
        
apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        procps \
        cgroup-tools \
        curl \
        wget \
        vim \
        # libmsquic requirements
        gnupg2 \
        software-properties-common

apt-get update \
    && apt-get install -y --no-install-recommends \
        g++ make binutils autoconf automake autotools-dev libtool pkg-config \
        zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
        libc-ares-dev libjemalloc-dev libsystemd-dev \
        python python3-dev python-setuptools

NGHTTP2_VERSION=1.46.0
cd /tmp \
    && curl -L "https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_VERSION}/nghttp2-${NGHTTP2_VERSION}.tar.gz" -o "nghttp2-${NGHTTP2_VERSION}.tar
.gz" \
    && tar -zxvf "nghttp2-${NGHTTP2_VERSION}.tar.gz" \
    && cd /tmp/nghttp2-$NGHTTP2_VERSION \
    && ./configure \
    && make \
    && make install || true

echo " Installing dotnet "
cd ~
wget https://download.visualstudio.microsoft.com/download/pr/807f9d72-4940-4b1a-aa4a-8dbb0f73f5d7/cb666c22a87bf9413f29615e0ba94500/dotnet-sdk-6.0.200-linux-x64.tar.gz

mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-6.0.200-linux-x64.tar.gz -C $HOME/dotnet

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

dotnet tool install -g Microsoft.Crank.Controller --version "0.2.0-*"
dotnet tool install -g Microsoft.Crank.Agent --version "0.2.0-*"

cat << \EOF >> ~/.bashrc
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
export PATH="$PATH:/root/.dotnet/tools"
EOF
source ~/.bashrc
echo "                                                         "
echo "****** Detailed Information ******"
echo "                                                        "
dotnet --info
