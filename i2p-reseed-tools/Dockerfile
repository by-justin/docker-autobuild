FROM golang:alpine as builder

COPY i2p-tools /build
WORKDIR /build

RUN \
    apk add binutils && \
    go mod init reseed-tools && \
    go get github.com/MDrollette/i2p-tools && \
    go mod vendor && \
    go build && \
    strip reseed-tools

FROM alpine

COPY --from=builder /build/reseed-tools /usr/local/bin
RUN mkdir /workdir 

WORKDIR /workdir
EXPOSE 8443
VOLUME /netDb