<img src="https://raw.githubusercontent.com/justin-himself/docker-autobuild/master/geph4-client/logo.png" width="50%" alt="迷雾通 logo">

---

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)

## Description

This is a mutiarch iamge of geph4-client, with built-in redsocks functionality.

The purpose of this image is to:

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
  -p 9809:9809 \
  -p 9909:9909 \
  -p 9910:9910 \
  -p 15353:15353 \
  -p 12345:12345 \
  -p 10053:10053 \
  -v /path/to/config:/config \
  -e USERNAME=`#optional` \
  -e PASSWORD=`#optional` \
  -e EXIT_SERVER=`#optional` \
  --name geph4-client \
  --restart unless-stopped \
  --log-driver local \
  --log-opt max-size=10m \
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
| `-p 12345`        | Redsocks TCP proxy port                          |
| `-p 10053`        | Redsocks UDP proxy port                          |
| `-v config`       | Where to store Geph's credential cache.          |
| `-e USERNAME=`    | Geph username. Default will use guest account.   |
| `-e PASSWORD=`    | Geph password. Default will use guest password.  |
| `-e EXIT_SERVER=` | Exit server, example: `1.mtl.ca.ngexits.geph.io` |
| `--mac-address`   | Set mac-address of the container, optional       |
| `--ip`            | Set ip-address of the container, optional        |

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

| Parameters               | Preset Value | Function                                                                                                                                                                                                                     |
| ------------------------ | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-e EXCLUDE_PRC=`        | `true`       | Whether or not to exclude PRC domains                                                                                                                                                                                        |
| `-e STICKY_BRIDGES=`     | `false`      | Whether or not to stick to the same set of bridges                                                                                                                                                                           |
| `-e USE_BRIDGES=`        | `false`      | Whether or not to use bridges                                                                                                                                                                                                |
| `-e USE_TCP=`            | `false`      | Whether or not to force TCP mode                                                                                                                                                                                             |
| `-e TCP_SHARD_COUNT=`    | `""`         | Number of TCP connections to use per session. This works around lossy links, per-connection rate limiting, etc (default: 6)                                                                                                  |
| `-e TCP_SHARD_LIFETIME=` | `""`         | Lifetime of a single TCP connection. Geph will switch to a different TCP connection within this many seconds (default: 1)                                                                                                    |
| `-e UDP_SHARD_COUNT=`    | `""`         | Number of local UDP ports to use per session. This works around situations where unlucky ECMP routing sends flows down a congested path even when other paths exist, by "averaging out" all the possible routes (default: 1) |
| `-e UDP_SHARD_LIFETIME=` | `""`         | Lifetime of a single UDP port. Geph will switch to a different port within this many seconds (default: 30)                                                                                                                   |
| `-e EXTRA_PARAMS=`       | `""`         | Any text here will be appended after the command.                                                                                                                                                                            |

## 配合 iptables 使用做 TCP 透明代理

> 启动 container

```bash
docker run -d \
  -p 9809:9809 \
  -p 9909:9909 \
  -p 9910:9910 \
  -p 15353:15353 \
  -p 12345:12345 \
  -v /path/to/config:/config \
  -e USERNAME=`#optional` \
  -e PASSWORD=`#optional` \
  -e EXIT_SERVER=`#optional` \
  --name geph4-client \
  --restart unless-stopped \
  --net host \
  --log-driver local \
  --log-opt max-size=10m \
  justinhimself/geph4-client
```

> 设置防火墙  
> https://community.geph.io/t/topic/3780/2

```bash
#全局TCP代理规则    iptables+REDIRECT
iptables -t nat -N REDTCP
iptables -t nat -A REDTCP -d 0.0.0.0/8 -j RETURN
iptables -t nat -A REDTCP -d 10.0.0.0/8 -j RETURN
iptables -t nat -A REDTCP -d 100.64.0.0/10 -j RETURN
iptables -t nat -A REDTCP -d 127.0.0.0/8 -j RETURN
iptables -t nat -A REDTCP -d 169.254.0.0/16 -j RETURN
iptables -t nat -A REDTCP -d 172.16.0.0/12 -j RETURN
iptables -t nat -A REDTCP -d 192.168.0.0/16 -p tcp ! --dport 53 -j RETURN
iptables -t nat -A REDTCP -d 198.18.0.0/15 -j RETURN
iptables -t nat -A REDTCP -d 224.0.0.0/4 -j RETURN
iptables -t nat -A REDTCP -d 240.0.0.0/4 -j RETURN
iptables -t nat -A REDTCP -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A PREROUTING -p tcp -j REDTCP

# 局部UDP代理规则 (开启全局UDP 这部分要注释掉) 手动指定IP端口 可解决DNS污染
iptables -t nat -N REDDNS
iptables -t nat -A REDDNS -p udp --dport 53 -j REDIRECT --to-ports 10053
iptables -t nat -A PREROUTING -p udp -j REDDNS
```
