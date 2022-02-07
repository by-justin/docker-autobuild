FROM debian:latest AS builder   

COPY hosts.sh /
RUN apt-get update && apt-get install -y dnsutils
RUN bash /hosts.sh

FROM lscr.io/linuxserver/jellyfin

COPY add_hosts.sh /
COPY --from=builder /hosts /hosts
RUN echo "bash /add_hosts.sh" >> /docker-mods
