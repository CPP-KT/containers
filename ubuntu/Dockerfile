FROM ubuntu:24.04
LABEL maintainer="CPP-KT"

WORKDIR /root

ARG COMPILER_TYPE
ARG COMPILER_VERSION

ENV CMAKE_GENERATOR=Ninja

ENV CMAKE_CXX_COMPILER_LAUNCHER=/usr/bin/ccache
ENV CCACHE_DIR=/var/cache/ccache

RUN --mount=type=bind,target=util,source=util \
    apt-get update -qq && \
    util/install-base-utils.sh && \
    util/install-${COMPILER_TYPE}.sh ${COMPILER_VERSION} && \
    util/install-extra-utils.sh && \
    # cleanup
    apt-get autoremove -y --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENV CCACHE_NOHASHDIR=true
ENV CCACHE_IGNOREOPTIONS=-ffile-prefix-map=*
ENV CCACHE_READONLY=true
ENV CCACHE_TEMPDIR=/tmp/ccache
