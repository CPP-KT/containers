FROM ubuntu:23.10
LABEL maintainer="CPP-KT"

WORKDIR /root

ARG COMPILER_TYPE
ARG COMPILER_VERSION

ENV CMAKE_GENERATOR Ninja
ENV CMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake
ENV VCPKG_DEFAULT_BINARY_CACHE /var/cache/vcpkg/

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

ENTRYPOINT ["/bin/bash"]
