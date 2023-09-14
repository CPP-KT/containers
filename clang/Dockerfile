ARG DEBIAN_VERSION
FROM bitnami/minideb:${DEBIAN_VERSION}
LABEL maintainer="CPP-KT"

WORKDIR /root

COPY common/ common/
COPY clang/install-clang.sh ./

ENV CC clang -stdlib=libc
ENV CXX clang++ -stdlib=libc++
ENV CMAKE_GENERATOR Ninja
ENV VCPKG_DEFAULT_BINARY_CACHE /root/vcpkg-cache/

ARG LLVM_VERSION

RUN apt-get update -qq && \
    common/install-base-utils.sh && \
    ./install-clang.sh $LLVM_VERSION && \
    common/install-all.sh

RUN rm install-clang.sh
RUN rm -rf common
