FROM alpine:latest as builder1

# build lookbusy
COPY ./lookbusy-1.4.tar.gz /
RUN tar -zxvf /lookbusy-1.4.tar.gz
RUN  apk add --update cmake gcc build-base openssl-dev curl-dev libxml2-dev
RUN cd lookbusy-1.4 && chmod +x ./configure &&\
    ./configure && make && chmod +x lookbusy

FROM golang:alpine as builder2
COPY ./speedtest-go /speedtest-go
RUN cd /speedtest-go &&\
    go build && chmod +x speedtest-go

FROM alpine:latest
COPY rootfs/ /
COPY --from=builder1 /lookbusy-1.4/lookbusy /usr/bin/
COPY --from=builder2 /speedtest-go/speedtest-go /usr/bin/
ENV CPU_UTIL=10 MEM_UTIL=10 SPEEDTEST_INTERVAL=7200
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]