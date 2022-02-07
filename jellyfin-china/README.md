## Jellyfin China

![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)

> This image is built based on `linuxserver/jellyfin`

This image adds modified hosts file to help jellyfin users in China access *The movie db* and *The open movie db*.

### How to use 

The only differnce between this image and the original linuxserver build is /etc/hosts. Simpy substitute:

```
linuxserver/jellyfin -> justinhimself/jellyfin-china
lscr.io/linuxserver/jellyfin -> justinhimself/jellyfin-china
```