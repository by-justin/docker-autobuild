# i2pd-tools

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

> multiarch, i2pd-tools image that works out of the box

## Quick start

```bash
docker run --rm -it \
  -v ${PWD}:/workdir \
  justinhimself/i2pd-tools \
  /usr/bin/keygen privkey.dat
```

See [PurpleI2P/i2pd-tools](https://github.com/PurpleI2P/i2pd-tools) for documentation.
