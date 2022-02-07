FROM alpine:latest as builder
COPY p910nd /build
RUN \
  apk add --update gcc make build-base &&\
  cd /build && make && chmod +x ./p910nd

FROM alpine:latest
WORKDIR /
RUN mkdir /var/lock/subsys
COPY --from=builder /build/p910nd /usr/sbin/
ENTRYPOINT ["/usr/sbin/p910nd"]
