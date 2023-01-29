FROM debian:stable-slim as dependencies

ARG FLUTTER_VERSION=3.0.5

# prequesites
RUN apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
        curl \
        file \
        unzip \
        xz-utils \
        zip \
        libglu1-mesa \
        bash \
        git \
        clang \
        cmake \
        ninja-build \
        pkg-config

# install flutter
WORKDIR /install
RUN git clone -b "${FLUTTER_VERSION}" --single-branch --depth 1 https://github.com/flutter/flutter.git

FROM scratch

COPY --from=dependencies /install/flutter /etc/flutter

ENV PATH="/etc/flutter/bin:$PATH"

RUN ["flutter", "precache"]

RUN apt-get autoremove -y \
    && apt-get clean
