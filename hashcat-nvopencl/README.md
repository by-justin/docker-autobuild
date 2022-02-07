## HashCat-NVidia-OpenCL

![](https://img.shields.io/badge/x86_64-red)


This is a minimal image that supports running hashcat on nvidia gpus using opencl.  
Original dockerfile is sourced from [dizcza/docker-hashcat](https://github.com/dizcza/docker-hashcat), stripped cuda support to drastically reduce image size.

## Quick Start

Make sure the host has nvidia drivers and [NVidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) properly installed.

```bash
docker run --gpus all --rm -it justinhimself/hashcat-nvopencl /bin/bash
$ nvidia-smi
$ hashcat -I
$ hashcat -b
```

For more information, refer to the [official hashcat documentation](https://hashcat.net/hashcat/).
