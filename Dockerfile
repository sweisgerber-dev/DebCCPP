FROM debian:stable-slim

LABEL maintainer="sweisgerber.dev@gmail.com"

WORKDIR /workspace

RUN echo "*** Installing build-essential, gcc, g++, clang and cmake ***" \
  && DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get dist-upgrade -y \
  `# && echo "deb http://ftp.us.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list.d/jessie.list `\
  `# && echo "deb http://ftp.us.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list.d/unstable.list `\
  && apt-get update \
  && apt-get install -y \
    bash \
    build-essential \
    cmake \
    gcc \
    g++ \
    clang \
    clang-3.8 \
    clang-3.9 \
    clang-4.0 \
    clang-tidy \
  && apt-get autoremove --purge -y \
  && apt-get autoclean -y \
  && rm -rf /var/cache/apt/* /tmp/* \
  && echo "Setting g++ 6 as default compiler" \
  && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 1

ENTRYPOINT ["/usr/bin/env", "bash"]
