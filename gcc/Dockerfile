FROM ubuntu:23.10
LABEL maintainer="CPP-KT"

WORKDIR /root

ENV CC /usr/bin/gcc
ENV CXX /usr/bin/g++
ENV CMAKE_GENERATOR Ninja
ENV CMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake
ENV VCPKG_DEFAULT_BINARY_CACHE /var/cache/vcpkg/

ARG GCC_VERSION

RUN --mount=type=bind,target=common,source=common \
    --mount=type=bind,target=install-gcc.sh,source=gcc/install-gcc.sh \
    apt-get update -qq && \
    common/install-base-utils.sh && \
    ./install-gcc.sh ${GCC_VERSION} && \
    common/install-all.sh && \
    # cleanup
    apt-get autoremove -y --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENTRYPOINT ["/bin/bash"]
