FROM rust:latest
RUN \ 
  apt update && apt install -y \
    gcc clang g++ zlib1g-dev libmpc-dev curl \
    libmpfr-dev libgmp-dev  build-essential && \
  git clone https://github.com/geph-official/geph4-client.git /geph4-client && \
  cd /geph4-client && cargo build --release &&\
  chmod u+x /geph4-client/target/release/geph4-client 

# final image
FROM debian:latest

COPY --from=0 /geph4-client/target/release/geph4-client /usr/bin/geph4-client
COPY root/ /

RUN \
  chmod u+x /entrypoint.sh /keep-alive.sh &&\
  apt update && apt install -y \
    curl ca-certificates jq redsocks &&\
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

EXPOSE 9809 9909 9910 15353 12345 10053
VOLUME /config
WORKDIR /

# 1 means flag is present
ENV EXCLUDE_PRC=true
ENV STICKY_BRIDGES=false
ENV USE_BRIDGES=false
ENV USE_TCP=false

# empty means flag not present
ENV USERNAME=""
ENV PASSWORD=""
ENV EXIT_SERVER=""
ENV TCP_SHARD_COUNT=""
ENV TCP_SHARD_LIFETIME=""
ENV UDP_SHARD_COUNT=""
ENV UDP_SHARD_LIFETIME=""
ENV EXTRA_PARAMS=""

ENTRYPOINT ["bash", "/entrypoint.sh"]
