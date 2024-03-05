FROM bitnami/minideb:bookworm
LABEL maintainer="CPP-KT"

WORKDIR /root

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++ -stdlib=libc++
ENV CMAKE_GENERATOR Ninja
ENV CMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake
ENV VCPKG_DEFAULT_BINARY_CACHE /var/cache/vcpkg/

ARG LLVM_VERSION

RUN --mount=type=bind,target=common,source=common \
    --mount=type=bind,target=install-clang.sh,source=clang/install-clang.sh \
    apt-get update -qq && \
    common/install-base-utils.sh && \
    ./install-clang.sh $LLVM_VERSION && \
    common/install-all.sh && \
    # cleanup
    apt-get autoremove -y --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENTRYPOINT ["/bin/bash"]
