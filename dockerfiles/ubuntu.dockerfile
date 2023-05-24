FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

COPY ./taiwan-sources-jammy.list /etc/apt/sources.list

RUN apt update -y
RUN apt install -y git llvm clang vim cmake curl fish g++

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
ENV PATH="/root/.cargo/bin:$PATH"
# Trigger the downloading for Rust components
RUN <<EOT
    mkdir /tmp/deleteme
    cd /tmp/deleteme
    cargo init
    cargo add zenoh
    rm -rf /tmp/deleteme
EOT
