FROM debian:stable-slim

LABEL maintainer="sweisgerber.dev@gmail.com"

ENV USER=user
ENV USER_ID_DEFAULT=1000
ENV GROUP_ID_DEFAULT=1000

ENV WORKDIR=/workspace
WORKDIR /workspace

RUN echo "*** Installing build-essential, gcc, g++, clang and cmake ***" \
  && DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get dist-upgrade -y \
  && echo "deb http://ftp.us.debian.org/debian oldoldstable main contrib non-free" >> /etc/apt/sources.list.d/jessie.list \
  && echo "deb http://ftp.us.debian.org/debian oldstable main contrib non-free" >> /etc/apt/sources.list.d/oldstable.list \
  && echo "deb http://ftp.us.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list.d/buster-backports.list \
  && apt-get update \
  && apt-get install -y \
    apt-utils \
    apt-transport-https \
    bash \
    build-essential \
    cmake \
    ninja-build \
    gcc \
    gcc-7 \
    g++ \
    g++-7 \
    libc-dbg \
    gosu \
    git \
    clang \
    clang-6.0 \
    clang-7 \
    clang-8 \
    clang-tidy \
    python3 \
    python3-pip \
    python3-virtualenv \
    python3-pyelftools \
    python-pip \
    python-virtualenv \
    python-pyelftools \
    valgrind \
  && apt-get autoremove --purge -y \
  && apt-get autoclean -y \
  && rm -rf /var/cache/apt/* /tmp/* \
  && echo "Setting g++ 8 as default compiler" \
  && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 1

# Create a non-root user that will perform the actual build
# RUN id ${USER} 2>/dev/null || addgroup -S latex && adduser -S latex -G latex useradd --uid ${USER_ID_DEFAULT} --create-home --shell /bin/bash ${USER}
# Create a non-root user that will perform the actual build
RUN id ${USER} 2>/dev/null || useradd --uid ${USER_ID_DEFAULT} --create-home --shell /bin/bash ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

RUN mkdir -p ${WORKDIR}; \
    chown ${USER}:${USER} ${WORKDIR};

COPY config/.bashrc /home/${USER}/.bashrc
RUN chown ${USER}:${USER} /home/${USER}/.bashrc

COPY config/entrypoint.sh /usr/local/bin/entrypoint.sh

# EXPOSE ###############################################################################################################
VOLUME ["/workspace"]
WORKDIR ${WORKDIR}

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
