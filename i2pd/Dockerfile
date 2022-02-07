FROM alpine:latest as builder

COPY i2pd /build

RUN apk update \
    && apk --no-cache --virtual build-dependendencies add \
     make gcc g++ libtool zlib-dev boost-dev build-base \
      openssl-dev openssl miniupnpc-dev \
    && cd /build \
    && make USE_UPNP=yes \
    && strip i2pd 

# 2. Adding required libraries to run i2pd to ensure it will run.

FROM alpine:latest

COPY --from=builder  /build/i2pd /usr/local/bin
COPY i2pd/contrib/certificates /config/certificates
COPY rootfs/ /

RUN \
  apk --no-cache add boost-filesystem boost-system \
    boost-program_options boost-date_time boost-thread \
    boost-iostreams openssl miniupnpc musl-utils libstdc++ &&\
  cp -r /config /config.default

VOLUME /config
EXPOSE 7070 4444 4447 4567 7656 4567

CMD [ "sh", "/entrypoint.sh" ]
