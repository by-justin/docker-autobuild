# -------- Stage 1: Builder --------
FROM nvidia/cuda:12.9.1-cudnn-devel-ubuntu20.04 AS builder

LABEL stage=builder

ENV DEBIAN_FRONTEND=noninteractive
ENV HASHCAT_VERSION=master

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    make \
    pkg-config \
    wget \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g-dev \
    libpcap-dev \
    clinfo \
    pciutils && \
    rm -rf /var/lib/apt/lists/*

# Clone and build hashcat
WORKDIR /opt/hashcat
RUN git clone https://github.com/hashcat/hashcat.git . && \
    git checkout ${HASHCAT_VERSION} && \
    make install -j$(nproc);

RUN cd /opt/hashcat && rm -rf \
    .git .github Python bridges deps docker docs extra include layouts obj src

# -------- Stage 2: Final Image --------
FROM nvidia/cuda:12.9.1-base-ubuntu20.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

RUN apt-get update && apt-get install -y --no-install-recommends \
    ocl-icd-libopencl1 \
    clinfo \
    && rm -rf /var/lib/apt/lists/*

# Set up NVIDIA ICD for OpenCL
RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# Copy hashcat from builder
RUN mkdir -p /opt/hashcat
COPY --from=builder /opt/hashcat /opt/hashcat

# Add hashcat to PATH
ENV PATH="/opt/hashcat:${PATH}"

WORKDIR /opt/hashcat
CMD ["hashcat"]


