ARG FEDORA_VERSION=37

FROM fedora:${FEDORA_VERSION}

ARG FLUTTER_VERSION=3.0.5

# prequesites
RUN yum install -y curl file unzip xz zip mesa-libGL bash git clang cmake ninja-build pkgconfig

# install flutter
WORKDIR /install
RUN git clone -b "${FLUTTER_VERSION}" --single-branch --depth 1 https://github.com/flutter/flutter.git

# move flutter to /etc/flutter
RUN mv flutter /etc/flutter
RUN ["git", "config", "--global", "--add", "safe.directory", "/etc/flutter"]

# cheanup
WORKDIR /
RUN ["rm", "-rf", "install"]

# install path
ENV PATH="${PATH}:/etc/flutter/bin"

RUN ["flutter", "precache"]