FROM debian:bullseye

WORKDIR /workdir 

# Install necessary tools and dependencies
RUN \
  apt update &&\
  apt install -y wget build-essential perl zlib1g-dev libc6-dev musl musl-dev musl-tools pkg-config binutils &&\
  rm -rf /var/lib/apt/lists/*

# Download and build OpenSSL
RUN \ 
  wget https://www.openssl.org/source/openssl-1.1.1u.tar.gz &&\
  tar -xzf openssl-1.1.1u.tar.gz &&\
  cd openssl-1.1.1u &&\
  sed -i 's|<linux/mman.h>|<sys/mman.h>|g' crypto/mem_sec.c &&\
  # Detect architecture using uname and set ARCH_CONFIG
  ARCH=$(uname -m) && \
  if [ "$ARCH" = "x86_64" ]; then \
      ARCH_CONFIG="linux-x86_64"; \
  elif [ "$ARCH" = "armv7l" ]; then \
      ARCH_CONFIG="linux-armv4"; \
  elif [ "$ARCH" = "aarch64" ]; then \
      ARCH_CONFIG="linux-aarch64"; \
  elif [ "$ARCH" = "i386" ]; then \
      ARCH_CONFIG="linux-elf"; \
  elif [ "$ARCH" = "mips64" ]; then \
      ARCH_CONFIG="linux64-mips64"; \
  elif [ "$ARCH" = "ppc64le" ]; then \
      ARCH_CONFIG="linux-ppc64"; \
  elif [ "$ARCH" = "riscv64" ]; then \
      ARCH_CONFIG="linux64-riscv64"; \
  elif [ "$ARCH" = "s390x" ]; then \
      ARCH_CONFIG="linux64-s390x"; \
  else \
      echo "Unsupported architecture: $ARCH"; exit 1; \
  fi &&\
  # Use the ARCH_CONFIG variable in the Configure command
  CC=musl-gcc ./Configure no-shared no-zlib no-dso no-afalgeng $ARCH_CONFIG -static &&\
  make -j8 &&\
  make install &&\
  rm -rf /workdir/*

