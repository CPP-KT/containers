ARG GCC_VERSION
FROM gcc:${GCC_VERSION}
LABEL maintainer="CPP-KT"

WORKDIR /root

COPY common/ common/

ENV CC /usr/local/bin/gcc
ENV CXX /usr/local/bin/g++
ENV CMAKE_GENERATOR Ninja
ENV VCPKG_DEFAULT_BINARY_CACHE /var/cache/vcpkg/

RUN apt-get update -qq && \
    ln -sf ${CC} /usr/bin/cc && \
    ln -sf ${CXX} /usr/bin/c++ && \
    common/install-all.sh

RUN rm -rf common
