## LookBusy

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

This the docker image for lookbusy.

Lookbusy is a tool for making systems busy. It uses relatively simple techniques to generate CPU activity, memory and disk utilization and traffic.

Oracle 一键保活, CPU 内存占用 10% + 每两个小时一次 Speedtest.

### Why look busy

https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm

![Oralce Nonsense](https://raw.githubusercontent.com/justin-himself/docker-autobuild/master/lookbusy/oracle_nonsense.png)

## Quick Start

**For Oracle**

If you are bypassing Oracle policy stated above, simply execute:

```bash
docker run  \
  --name lookbusy \
  -e IS_ORACLE=1 \
  -e CPU_UTIL=10 \
  -e MEM_UTIL=10 \
  -e SPEEDTEST_INTERVAL=7200 \
  --restart always \
  -d justinhimself/lookbusy
```

The script will automate everything for you, including:

- Keep 10% CPU busy (dynammically)
- Keep 10% Memory occupied for ARM Instance
- Run a speedtest every 2hrs

Set `-e SPEEDTEST_INTERVAL=0` to disable speedtest. 


**Normal use**

IF you just want to use lookbusy, just use it like you normal would.

```bash
docker run  \
  --name lookbusy \
  -d justinhimself/lookbusy -h
```

## Details

**How lookbusy works?**

lookbusy generates synthetic CPU, memory and disk access loads on a host. CPU
load is induced by simple arithmetic looping (with as little memory bandwidth
consumption as feasible) alternating with periods of sleeping in an attempt to
generate the degree of utilization selected. Memory load is induced by
allocating a buffer of a controllable size, then steadily stirring it to keep
the pages active from the VM standpoint. Disk load is induced through
creation of one or more files, and copying blocks of it between two moving
positions.

**If CPU util is already 10%, will running this program cost extra?**

No.

But note that this program would constanly consume 10% of your memory on ARM instance no matter what your current memory load is.
