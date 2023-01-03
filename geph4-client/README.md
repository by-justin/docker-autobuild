<img src="logo.png" width="50%" alt="迷雾通 logo">

---

![](https://img.shields.io/badge/ARCH-x86-9cf)
![](https://img.shields.io/badge/ARCH-x86_64-red)
![](https://img.shields.io/badge/ARCH-ARM_64-ff69b4)

## Description

This is a mutiarch iamge of geph4-client. The purpose of this image is to:

- provide a daily build of geph4-client binary
- make it easier to run geph4 on operating systems like Openwrt

## Usage

Here's some instrction on how to run the container.

> To obtain the newest binary of geph4, you can copy the file out of docker image

```bash
docker run --rm --name geph4-tmp -d justinhimself/geph4-client
docker cp geph4-tmp:/usr/bin/geph4-client .
docker stop geph4-tmp && docker rm geph4-tmp
```

> to run the container

```bash
docker run -d \
  --name geph4-client \
  --restart unless-stopped \
  -p 9809:9809 \
  -p 9909:9909 \
  -p 9910:9910 \
  -p 15353:15353 \
  -v /path/to/config:/config \
  -e USERNAME=`#optional` \
  -e PASSWORD=`#optional` \
  -e EXIT_SERVER=`#optional` \
  justinhimself/geph4-client
```

## Parameters

Here's an explanation for the parameters above:

| Parameters        | Function                                         |
| ----------------- | ------------------------------------------------ |
| `-p 9809`         | Where to listen for REST-based local connections |
| `-p 9909`         | Where to listen for SOCKS5 connections           |
| `-p 9910`         | Where to listen for HTTP proxy connections       |
| `-p 15353`        | Where to listen for proxied DNS requests         |
| `-v config`       | Where to store Geph's credential cache.          |
| `-e USERNAME=`    | Geph username. Default will use guest account.   |
| `-e PASSWORD=`    | Geph password. Default will use guest password.  |
| `-e EXIT_SERVER=` | Exit server, example: `1.mtl.ca.ngexits.geph.io` |

Container will output a list of exit servers that you can use in docker log.

**Additional Parameters**

There are also additional parameters that you can use:

```bash
  -e EXCLUDE_PRC=`#optional` \
  -e STICKY_BRIDGES=`#optional` \
  -e USE_BRIDGES=`#optional` \
  -e USE_TCP=`#optional` \
  -e TCP_SHARD_COUNT=`#optional` \
  -e TCP_SHARD_LIFETIME=`#optional` \
  -e UDP_SHARD_COUNT=`#optional` \
  -e UDP_SHARD_LIFETIME=`#optional` \
  -e EXTRA_PARAMS=`#optional` \
```

Here's an explanation for the additional parameters. Leave these field empty will not add the flag (use default)

| Parameters               | Default Value | Function                                                                                                                                                                                                        |
| ------------------------ | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-e EXCLUDE_PRC=`        | `true`        | Whether or not to exclude PRC domains                                                                                                                                                                           |
| `-e STICKY_BRIDGES=`     | `false`       | Whether or not to stick to the same set of bridges                                                                                                                                                              |
| `-e USE_BRIDGES=`        | `false`       | Whether or not to use bridges                                                                                                                                                                                   |
| `-e USE_TCP=`            | `false`       | Whether or not to force TCP mode                                                                                                                                                                                |
| `-e TCP_SHARD_COUNT=`    | `""`          | Number of TCP connections to use per session. This works around lossy links, per-connection rate limiting, etc                                                                                                  |
| `-e TCP_SHARD_LIFETIME=` | `""`          | Lifetime of a single TCP connection. Geph will switch to a different TCP connection within this many                                                                                                            |
| `-e UDP_SHARD_COUNT=`    | `""`          | Number of local UDP ports to use per session. This works around situations where unlucky ECMP routing sends flows down a congested path even when other paths exist, by "averaging out" all the possible routes |
| `-e UDP_SHARD_LIFETIME=` | `""`          | Lifetime of a single UDP port. Geph will switch to a different port within this many seconds                                                                                                                    |
| `-e EXTRA_PARAMS=`       | `""`          | Any text here will be appended after the command.                                                                                                                                                               |

## Build locally

The Dockerfile is publically availiable at [justin-himself/docker-autobuild](https://github.com/justin-himself/docker-autobuild). Execute the followling command if you want to build a custom version of the image.

```bash
git clone https://github.com/justin-himself/docker-autobuild.git
cd docker-autobuild/gephgui
docker build \
  --no-cache \
  --pull \
  -t justin-himself/gephgui:latest .
```