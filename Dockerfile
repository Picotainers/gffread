# syntax=docker/dockerfile:1

FROM debian:bookworm-slim AS builder

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    g++ \
    make \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN git clone --depth 1 https://github.com/gpertea/gffread.git gffread
WORKDIR /build/gffread
RUN git clone --depth 1 https://github.com/gpertea/gclib.git ../gclib
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
