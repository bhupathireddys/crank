FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env

COPY . .

ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1

# Build self contained

RUN dotnet publish -c Release src/Microsoft.Crank.Controller --output /app --framework net6.0

# Build runtime image
# FROM mcr.microsoft.com/dotnet/aspnet:6.0
# Use SDK image as it is required for the dotnet tools
FROM mcr.microsoft.com/dotnet/sdk:6.0

ARG CPUNAME=x86_64


# Install dependencies
RUN apt-get update \
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

# Install HTTP/3 support

RUN if [ "$(uname -m)" != "aarch64" ] ; then curl -O https://packages.microsoft.com/debian/10/prod/pool/main/libm/libmsquic/libmsquic-1.5.0-amd64.deb ; fi
RUN if [ "$(uname -m)" != "aarch64" ] ; then dpkg -i libmsquic-1.5.0-amd64.deb ; fi

# Build and install h2load. Required as there isn't a way to distribute h2load as a single file to download
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        g++ make binutils autoconf automake autotools-dev libtool pkg-config \
        zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
        libc-ares-dev libjemalloc-dev libsystemd-dev \
        python python3-dev python-setuptools

# If nghttp2 build fail just ignore it
ENV NGHTTP2_VERSION 1.46.0
RUN cd /tmp \
    && curl -L "https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_VERSION}/nghttp2-${NGHTTP2_VERSION}.tar.gz" -o "nghttp2-${NGHTTP2_VERSION}.tar.gz" \
    && tar -zxvf "nghttp2-${NGHTTP2_VERSION}.tar.gz" \
    && cd /tmp/nghttp2-$NGHTTP2_VERSION \
    && ./configure \
    && make \
    && make install || true


ADD docker/azure_controller/run_crank.sh /app/run_crank.sh
ADD docker/azure_controller/azure.profiles.yml /app/azure.profiles.yml
RUN chmod +x /app/run_crank.sh

COPY --from=build-env /app /app

ENTRYPOINT [ "/app/run_crank.sh" ]
