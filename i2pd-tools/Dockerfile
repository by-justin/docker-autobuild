FROM alpine:latest as builder

COPY i2pd-tools /src

RUN apk update \
    && apk --no-cache --virtual build-dependendencies add \
     make gcc \g++ libtool zlib-dev boost-dev build-base \
      openssl-dev \
    && cd /src \
    && make \
    && mkdir /build \
    && find . -type f ! -name "*.*" -maxdepth 1 -exec cp {} /build \; \
    && cd /build \
    && rm LICENSE Makefile \
    && strip ./*


# 2. Adding required libraries to run i2pd to ensure it will run.

FROM alpine:latest

COPY --from=builder  /build/. /usr/local/bin

RUN \
  apk --no-cache add boost-filesystem boost-chrono \
    boost-program_options boost-date_time \
    libssl1.1 zlib \
  && mkdir /workdir

WORKDIR /workdir

CMD ["/bin/sh"]
