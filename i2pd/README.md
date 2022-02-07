# i2pd

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

> multiarch, i2pd image that works out of the box

## Quick start

For i2pd to really work, host network mode is strongly adviced.

```bash
docker run \
  --name i2pd \
  --restart unless-stopped \
  --net host \
  -v i2pd_data:/config \
  -d justinhimself/i2pd
```

Simple as that.

## Introduction

i2pd (I2P Daemon) is a full-featured C++ implementation of I2P client.

I2P (Invisible Internet Protocol) is a universal anonymous network layer.  
All communications over I2P are anonymous and end-to-end encrypted, participants
don't reveal their real IP addresses.

I2P client is a software used for building and using anonymous I2P
networks. Such networks are commonly used for anonymous peer-to-peer
applications (filesharing, cryptocurrencies) and anonymous client-server
applications (websites, instant messengers, chat-servers).

I2P allows people from all around the world to communicate and share information
without restrictions.

## Features

- Distributed anonymous networking framework
- End-to-end encrypted communications
- Small footprint, simple dependencies, fast performance
- Rich set of APIs for developers of secure applications

## Resources

- [Website](http://i2pd.website)
- [Documentation](https://i2pd.readthedocs.io/en/latest/)
- [Wiki](https://github.com/PurpleI2P/i2pd/wiki)
- [Tickets/Issues](https://github.com/PurpleI2P/i2pd/issues)
- [Specifications](https://geti2p.net/spec)
- [Twitter](https://twitter.com/hashtag/i2pd)

## License

This project is licensed under the BSD 3-clause license, which can be found in the file
LICENSE in the root of the project source code.
