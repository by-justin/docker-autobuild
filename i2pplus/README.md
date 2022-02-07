# I2P+ in Docker

![](https://img.shields.io/badge/x86-9cf) ![](https://img.shields.io/badge/x86_64-red)![](https://img.shields.io/badge/ARM_64-ff69b4)![](https://img.shields.io/badge/ARM_v7-yellow) ![](https://img.shields.io/badge/ARM_v6-green)

### Very quick start

If you just want to give I2P+ a quick try or are using it on a home network, simply execute

```bash
docker run \
  --name i2pplus \
  --restart unless-stopped \
  -e JVM_XMX=2048m \
  -p 127.0.0.1:4444:4444 \
  -p 127.0.0.1:6668:6668 \
  -p 127.0.0.1:7657:7657 \
  -p 54321:12345 \
  -p 54321:12345/udp \
  -v i2phome:/i2p/.i2p \
  -v i2ptorrents:/i2psnark \
  -d justinhimself/i2pplus
```

Start a browser and go to `http://127.0.0.1:7657` to complete the setup wizard.

Note that this quick-start approach is not recommended for production deployments on remote servers. Please read the rest of this document for more information.

### Running a container

#### Environment Variables

It is possible to set the IP address where the I2P router is accessible by setting
the `IP_ADDR` environment variable in your `docker run` command or your `docker-compose`
file. For example, if you want to make your I2P router listen on all addresses, then
you should pass `-e IP_ADDR=0.0.0.0` to your `docker run` command.

It is also possible to configure the memory available to the I2P router using
environment variables. To do this, use the: `JVM_XMX` environment variable by passing,
for example, `-e JVM_XMX=256m`.

#### Volumes

The container requires a volume for the configuration data to be mounted. Optionally, you can mount a separate volume for torrent ("i2psnark") downloads. See the example below.

#### Memory usage

By the default the image limits the memory available to the Java heap to 512MB. You can override that with the `JVM_XMX` environment variable.

#### Ports

There are several ports which are exposed by the image. You can choose which ones to publish depending on your specific needs.

| Port  | Interface     | Description    | TCP/UDP     |
| ----- | ------------- | -------------- | ----------- |
| 4444  | 127.0.0.1     | HTTP Proxy     | TCP         |
| 4445  | 127.0.0.1     | HTTPS Proxy    | TCP         |
| 6668  | 127.0.0.1     | IRC Proxy      | TCP         |
| 7654  | 127.0.0.1     | I2CP Protocol  | TCP         |
| 7656  | 127.0.0.1     | SAM Bridge TCP | TCP         |
| 7657  | 127.0.0.1     | Router console | TCP         |
| 7658  | 127.0.0.1     | I2P Site       | TCP         |
| 7659  | 127.0.0.1     | SMTP Proxy     | TCP         |
| 7660  | 127.0.0.1     | POP Proxy      | TCP         |
| 7652  | LAN interface | UPnP           | TCP         |
| 7653  | LAN interface | UPnP           | UDP         |
| 12345 | 0.0.0.0       | I2NP Protocol  | TCP and UDP |

You probably want at least the Router Console (7657) and the HTTP Proxy (4444). If you want I2P to be able to receive incoming connections from the internet, and hence not think it's firewalled, publish the I2NP Protocol port (12345) - but make sure you publish to a different random port, otherwise others may be able to guess you're running I2P in a Docker image.

#### Networking

A best-practices guide for cloud deployments is beyond the scope of this document, but in general you should try to minimize the number of published ports, while exposing only the `I2NP` ports to the internet. That means that the services in the list above which are bound to `127.0.0.1` (which include the router console) will need to be accessed via other methods like ssh tunneling or be manually configured to bind to a different interface.
