FROM ubuntu:16.04
LABEL MAINTAINER Mitchell Olsthoorn <mitchell.olsthoorn@outlook.com>

# Make the GUI work in a container
ENV DEBIAN_FRONTEND=noninteractive

# Installing dependencies and cleaning up afterwards
RUN apt-get update && apt-get install -y --no-install-recommends \
# Build depenedencies
    git \
    python-setuptools \
    python-pip \
# Tribler dependencies
    libav-tools \
    libsodium18 \
    libx11-6 \
    python2.7 \
    python-apsw \
    python-chardet \
    python-cherrypy3 \
    python-configobj \
    python-crypto \
    python-cryptography \
    python-decorator \
    python-dnspython \
    python-ecdsa \
    python-feedparser \
    python-jsonrpclib \
    python-keyring \
    python-keyrings.alt \
    python-leveldb \
    python-libnacl \
    python-libtorrent \
    python-matplotlib \
    python-m2crypto \
    python-netifaces \
    python-networkx \
    python-pbkdf2 \
    python-pil \
    python-protobuf \
    python-pyasn1 \
    python-pyqt5 \
    python-pyqt5.qtsvg \
    python-requests \
    python-scipy \
    python-socks \
    python-twisted \
    vlc \
    && pip install pyaes \
# Cleanup
    && apt-get remove -y \
    python-setuptools \
    python-pip \
    && apt-get autoremove -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV HOME /home/tribler
ENV API_PORT 8085

# Create a local user and stop using root
RUN useradd -m --home-dir $HOME tribler \
    && chown -R tribler:tribler $HOME

USER tribler
WORKDIR $HOME

# Set building arguments
ARG REPO_URL=https://github.com/Tribler/tribler.git
ARG VERSION=next

# Get code from the repository
RUN git clone --recursive --depth 1 ${REPO_URL} -b ${VERSION} tribler

EXPOSE $API_PORT

CMD ["/home/tribler/tribler/tribler.sh"]
