ARG GCC_VERSION
FROM gcc:${GCC_VERSION}
LABEL maintainer="CPP-KT"

WORKDIR /root

COPY common/ common/

ENV CC gcc
ENV CXX g++
ENV CMAKE_GENERATOR Ninja
ENV VCPKG_DEFAULT_BINARY_CACHE /root/vcpkg-cache/

RUN apt-get update -qq && \
    ln -sf gcc /usr/bin/cc && \
    ln -sf g++ /usr/bin/c++ && \
    common/install-all.sh

RUN rm -rf common
