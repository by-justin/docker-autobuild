FROM alpine:latest

RUN \
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && echo '@edgecommunity http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk --no-cache --update add su-exec ca-certificates tor privoxy socat  \
    && mv /etc/tor/torrc.sample  /etc/tor/torrc \
    && cd /etc/privoxy && for v in *.new ; do mv "$v"  "$(basename "$v" .new)"; done \
    && echo "forward-socks5 / 0.0.0.0:9050 ." >> /etc/privoxy/config \
    && sed -i 's/listen-address\s*127.0.0.1:8118/listen-address 0.0.0.0:8118/g' /etc/privoxy/config \
    && sed -i \
        -e 's/#SOCKSPort 192.168.0.1:9100/SOCKSPort 0.0.0.0:9050/g' \
        -e 's/#ControlPort 9051/ControlPort 9052/g' \
        -e 's/Log notice file \/var\/log\/tor\/notices.log/Log notice stdout/g' \
        /etc/tor/torrc \
    && cp -r /etc/tor /etc/tor.default \
    && chown root /var/lib/tor




COPY rootfs/ /
CMD ["sh", "/entrypoint.sh"]
EXPOSE 9050/tcp 9051/tcp 8118/tcp
