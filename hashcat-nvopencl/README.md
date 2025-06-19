## HashCat-NVidia-OpenCL

![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/docker/image-size/justinhimself/hashcat-nvopencl/latest)

This is a minimal image (~200MB) that supports running hashcat on nvidia gpus using opencl.  
Original dockerfile is sourced from [dizcza/docker-hashcat](https://github.com/dizcza/docker-hashcat), stripped cuda support to drastically reduce image size.

### Quick Start

Make sure the host has nvidia drivers and [NVidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) properly installed.

```bash
docker run --gpus all --rm -it justinhimself/hashcat-nvopencl /bin/bash
$ nvidia-smi
$ hashcat -I
$ hashcat -b
```

For more information, refer to the [official hashcat documentation](https://hashcat.net/hashcat/).

### Performance Comparison

The following benchmarks were conducted on a Tesla P4 GPU using two separate environments: OpenCL 3.0 and CUDA 12.9.40, both with Hashcat v6.2.6 and default optimization settings.

The results indicate that switching to the CUDA backend yields a modest overall hashrate improvement of `4.68%` compared to OpenCL, with no significant performance differences observed across individual hash modes.

#### Chart

![](https://github.com/by-justin/docker-autobuild/blob/master/hashcat-nvopencl/bench.png?raw=true)


#### Table
| Hash Mode | Description                           | OpenCL      | CUDA        |
|-----------|---------------------------------------|------------------|------------------|
| 0         | MD5                                   | 15339.2 MH/s     | 15167.5 MH/s     |
| 100       | SHA1                                  | 5183.8 MH/s      | 5107.7 MH/s      |
| 1400      | SHA2-256                              | 1863.6 MH/s      | 1916.1 MH/s      |
| 1700      | SHA2-512                              | 561.7 MH/s       | 647.1 MH/s       |
| 22000     | WPA-PBKDF2-PMKID+EAPOL                | 257.4 kH/s       | 268.1 kH/s       |
| 1000      | NTLM                                  | 23986.4 MH/s     | 26173.0 MH/s     |
| 3000      | LM                                    | 13088.9 MH/s     | 12951.4 MH/s     |
| 5500      | NetNTLMv1 / NetNTLMv1+ESS             | 13305.4 MH/s     | 14768.5 MH/s     |
| 5600      | NetNTLMv2                             | 1032.7 MH/s      | 1175.8 MH/s      |
| 1500      | Traditional DES                       | 292.0 MH/s       | 216.6 MH/s       |
| 500       | md5crypt                              | 4366.6 kH/s      | 4619.8 kH/s      |
| 3200      | bcrypt                                | 11617 H/s        | 12187 H/s        |
| 1800      | sha512crypt                           | 83761 H/s        | 80269 H/s        |
| 7500      | Kerberos 5 AS-REQ                     | 210.7 MH/s       | 233.4 MH/s       |
| 13100     | Kerberos 5 TGS-REP                    | 206.4 MH/s       | 228.2 MH/s       |
| 15300     | DPAPI masterkey v1                    | 44483 H/s        | 47283 H/s        |
| 15900     | DPAPI masterkey v2                    | 19834 H/s        | 22466 H/s        |
| 7100      | macOS PBKDF2-SHA512                   | 256.1 kH/s       | 275.1 kH/s       |
| 11600     | 7-Zip                                 | 222.2 kH/s       | 197.6 kH/s       |
| 12500     | RAR3-hp                               | 29001 H/s        | 29343 H/s        |
| 13000     | RAR5                                   | 21912 H/s        | 24031 H/s        |
| 6211      | TrueCrypt RIPEMD160                   | 151.4 kH/s       | 170.4 kH/s       |
| 13400     | KeePass                                | 19872 H/s        | 20589 H/s        |
| 6800      | LastPass                               | 7253 H/s         | 7938 H/s         |
| 11300     | Bitcoin/Litecoin wallet.dat            | 2744 H/s         | 3087 H/s         |
