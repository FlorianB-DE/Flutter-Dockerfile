FROM debian:stable-slim

ARG FLUTTER_VERSION=3.0.5

# prequesites
RUN apt update
RUN apt upgrade -y

RUN apt install -y curl file unzip xz-utils zip libglu1-mesa bash git clang cmake ninja-build pkg-config

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