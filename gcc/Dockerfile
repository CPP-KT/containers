ARG GCC_VERSION
FROM gcc:${GCC_VERSION}
LABEL maintainer="CPP-KT"

WORKDIR /root

ENV CC /usr/local/bin/gcc
ENV CXX /usr/local/bin/g++
ENV CMAKE_GENERATOR Ninja
ENV CMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake
ENV VCPKG_DEFAULT_BINARY_CACHE /var/cache/vcpkg/

RUN --mount=type=bind,target=common,source=common \
    apt-get update -qq && \
    common/install-all.sh && \
    # cleanup
    apt-get autoremove -y --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENTRYPOINT ["/bin/bash"]
