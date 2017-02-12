FROM ubuntu:16.04
MAINTAINER Andrew Dunham <andrew@du.nham.ca>

# Set up environment
ENV LLVM_VERSION=3.9.1 \
    MUSL_VERSION=1.1.14 \
    RUST_VERSION=1.15.1 \
    RUST_BUILD_TARGET=all \
    RUST_BUILD_INSTALL=true \
    RUST_BUILD_CLEAN=true

ADD build.sh /build/build.sh
RUN apt-get update && \
    BUILD_DEPENDENCIES="\
        automake        \
        build-essential \
        cmake           \
        curl            \
        file            \
        make            \
        pkg-config      \
        python          \
    " && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yy gcc ca-certificates $BUILD_DEPENDENCIES && \
    /build/build.sh && \
    DEBIAN_FRONTEND=noninteractive apt-get remove -yy --auto-remove --purge $BUILD_DEPENDENCIES
