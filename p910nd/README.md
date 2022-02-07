## p910nd

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

> This image is built based on official p910nd package, with multiarch support

p910nd is a small printer daemon intended for diskless platforms that does not spool to disk but passes the job directly to the printer. Normally a lpr daemon on a spooling host connects to it with a TCP connection on port 910n (where n=0, 1, or 2 for lp0, 1 and 2 respectively). p910nd is particularly useful for diskless platforms. Common Unix Printing System (CUPS) supports this protocol, it's called the AppSocket protocol and has the scheme socket://. LPRng also supports this protocol and the syntax is lp=remotehost%9100 in /etc/printcap.

### Usage

- The -f option can be used to specify a different printer device, e.g.
  /dev/usblp0.
- The -i option can be used to specify binding to one address instead of
  all interfaces which is the default.
- The -b option turns on bidirectional copying.
- The -v option shows the version number.
- The -d option causes the daemon to run in the foreground in standalone
  mode and prints log messages to stdout for debugging.

find more from `man 8 p910nd`

### Examples

```bash
docker run -d \
  --name=p910nd \
  --privileged \
  -p 9100:9100 \
  -v /dev/usb/lp0:/dev/usb/lp0 \
  -v /var/lock/p910nd:/var/lock/p910nd \
  justinhimself/p910nd:latest '-b' '-d' '-f' '/dev/usb/lp0'
```

## Authors

[kenyapcomau/p910nd](https://github.com/kenyapcomau/p910nd)  
**Ken Yap** and others

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (GPL2).
