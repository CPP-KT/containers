FROM ubuntu:24.04
LABEL maintainer="CPP-KT"

WORKDIR /root

ARG COMPILER_TYPE
ARG COMPILER_VERSION

ENV CMAKE_GENERATOR=Ninja
ENV VCPKG_DEFAULT_BINARY_CACHE=/var/cache/vcpkg/
ENV CT_VCPKG_ROOT_DIR=/opt/vcpkg

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
