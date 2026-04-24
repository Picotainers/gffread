# syntax=docker/dockerfile:1

FROM debian:bookworm-slim AS builder

ARG DEBIAN_FRONTEND=noninteractive
ARG GFFREAD_VERSION=v0.12.9
ARG GFFREAD_URL=https://github.com/gpertea/gffread/archive/refs/tags/v0.12.9.tar.gz
ARG GFFREAD_SHA256=92eb4a52fdd14c5fd3684041ef2d040c44d7414d076467a326eea2efa087a085
ARG GCLIB_VERSION=v0.12.8
ARG GCLIB_URL=https://github.com/gpertea/gclib/archive/refs/tags/v0.12.8.tar.gz
ARG GCLIB_SHA256=a8dea4d273d6802f77f26a5394b1d66dfc1aba46a725c61e4c7399b756fb75e3

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    g++ \
    make \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN curl -fsSL "$GFFREAD_URL" -o gffread.tar.gz \
    && echo "$GFFREAD_SHA256  gffread.tar.gz" | sha256sum -c - \
    && tar -xzf gffread.tar.gz \
    && mv gffread-${GFFREAD_VERSION#v} gffread

RUN curl -fsSL "$GCLIB_URL" -o gclib.tar.gz \
    && echo "$GCLIB_SHA256  gclib.tar.gz" | sha256sum -c - \
    && tar -xzf gclib.tar.gz \
    && mv gclib-${GCLIB_VERSION#v} gclib

WORKDIR /build/gffread
RUN make release

FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/gffread/gffread /usr/local/bin/gffread

WORKDIR /data
CMD ["gffread", "--help"]
