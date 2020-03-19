FROM ubuntu:20.04
LABEL MAINTAINER Mitchell Olsthoorn <mitchell.olsthoorn@outlook.com>

# Make the GUI work in a container
ENV DEBIAN_FRONTEND=noninteractive

# Installing dependencies and cleaning up afterwards
RUN apt-get update && apt-get install -y --no-install-recommends \
# Build depenedencies
    git \
    python3-setuptools \
    python3-pip \
    build-essential \
    python3-dev \
# Tribler dependencies (apt)
    ffmpeg \
    libssl-dev \
    libx11-6 \
    x11-utils \
    vlc \
    libgmp-dev \
    python3 \
    python3-minimal \
    python3-pip \
    python3-libtorrent \
    python3-pyqt5 \
    python3-pyqt5.qtsvg \
    python3-scipy \
# Tribler dependencies (pip)
	&& pip3 install wheel \
	&& pip3 install \
	Pillow \
	pyyaml \
	bitcoinlib \
	cryptography \
	chardet \
	configobj \
	decorator \
	dnspython \
	ecdsa \
	feedparser \
	jsonrpclib \
	matplotlib \
	netifaces \
	networkx \
	pbkdf2 \
	pony \
	protobuf \
	psutil \
	pyaes \
	pyasn1 \
	pysocks \
	requests \
	lz4 \
	pyqtgraph \
# Cleanup
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
ARG VERSION=devel

# Get code from the repository
RUN git clone --recursive --depth 1 ${REPO_URL} -b ${VERSION} tribler

# Install IPv8 dependencies
RUN cd tribler/src/pyipv8 && pip3 install --upgrade -r requirements.txt

EXPOSE $API_PORT

CMD ["/home/tribler/tribler/src/tribler.sh"]
