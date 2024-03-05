FROM bitnami/minideb:bookworm
LABEL maintainer="CPP-KT"

WORKDIR /root

COPY common/ common/
COPY clang/install-clang.sh ./

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++ -stdlib=libc++
ENV CMAKE_GENERATOR Ninja
ENV CMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake
ENV VCPKG_DEFAULT_BINARY_CACHE /var/cache/vcpkg/

ARG LLVM_VERSION

RUN apt-get update -qq && \
    common/install-base-utils.sh && \
    ./install-clang.sh $LLVM_VERSION && \
    common/install-all.sh

RUN rm install-clang.sh
RUN rm -rf common

ENTRYPOINT ["/bin/bash"]
