# syntax=docker/dockerfile-upstream:master-labs
FROM debian:stable-slim

# prequesites
RUN apt update
RUN apt upgrade -y

RUN apt install -y curl file unzip xz-utils zip libglu1-mesa bash git

# install flutter
WORKDIR /install
ADD --keep-git-dir=true https://github.com/flutter/flutter.git ./flutter

# move flutter to /etc/flutter
RUN ["mv", "flutter", "/etc/flutter"]
RUN git config --global --add safe.directory /etc/flutter

# cheanup
WORKDIR /
RUN ["rm", "-rf", "install"]

# install path
ENV PATH="${PATH}:/etc/flutter/bin"

RUN ["flutter", "precache"]