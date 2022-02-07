## Tor Privoxy

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

> This image is a fork of [dockage/tor-privoxy](https://github.com/dockage/tor-privoxy), with multiarch support and latest alpine

This image combines Tor and Privoxy services to prepare proxy connection for http and shell.

# Getting started

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/justinhimself/tor-privoxy) and is the recommended method of installation.

```bash
docker pull justinhimself/tor-privoxy
```

Alternatively you can build the image yourself.

```bash
docker build -t justinhimself/tor-privoxy https://github.com/justinhimself/docker-autobuild.git#master:tor-privoxy
```

# Quick Start

> Keep everything default

```bash
docker run --name='tor-privoxy' -d \
  -p 9050:9050 \
  -p 9051:9051 \
  -p 8118:8118 \
justinhimself/tor-privoxy:latest
```

The exposed ports are:

- <code>9050</code>: Tor proxy (SOCKS5)
- <code>9051</code>: Tor control port
- <code>8118</code>: Privoxy (HTTP Proxy)

> Use custom configuration

You can make tor config and data dir persistent and add you own config.

```bash
docker run --name='tor-privoxy' -d \
  -p 9050:9050 \
  -p 9051:9051 \
  -p 8118:8118 \
  -v tor_config:/etc/tor \
  -v tor_data:/var/lib/tor \
justinhimself/tor-privoxy:latest
```

If container finds your tor_config dir is empty, it will automatically create default torrc.

# Maintenance

## Upgrading

To upgrade to newer releases:

- **Step 1**: Download the updated Docker image:

```bash
docker pull justinhimself/tor-privoxy
```

- **Step 2**: Stop the currently running image:

```bash
docker stop tor-privoxy
```

- **Step 3**: Remove the stopped container

```bash
docker rm -v tor-privoxy
```

- **Step 4**: Start the updated image

```bash
docker run --name tor-privoxy -d \
[OPTIONS] \
justinhimself/tor-privoxy:latest
```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it tor-privoxy sh
```
