FROM ghcr.io/bjia56/armv7l-wheel-builder:main

# https://solarianprogrammer.com/2018/05/06/building-gcc-cross-compiler-raspberry-pi/

# This should match the one on your raspi
ENV GCC_VERSION gcc-10.2.0
ENV GLIBC_VERSION glibc-2.17
ENV BINUTILS_VERSION binutils-2.35

RUN mkdir /gcc-cross
WORKDIR /gcc-cross

# Download and extract GCC
RUN wget https://ftp.gnu.org/gnu/gcc/${GCC_VERSION}/${GCC_VERSION}.tar.gz && \
    tar xf ${GCC_VERSION}.tar.gz && \
    rm ${GCC_VERSION}.tar.gz
# Download and extract LibC
RUN wget https://ftp.gnu.org/gnu/libc/${GLIBC_VERSION}.tar.bz2 && \
    tar xjf ${GLIBC_VERSION}.tar.bz2 && \
    rm ${GLIBC_VERSION}.tar.bz2
# Download and extract BinUtils
RUN wget https://ftp.gnu.org/gnu/binutils/${BINUTILS_VERSION}.tar.bz2 && \
    tar xjf ${BINUTILS_VERSION}.tar.bz2 && \
    rm ${BINUTILS_VERSION}.tar.bz2
# Download the GCC prerequisites
RUN cd ${GCC_VERSION} && contrib/download_prerequisites && rm *.tar.*

# Build BinUtils
RUN mkdir -p /opt/cross-pi-gcc
WORKDIR /gcc-cross/build-binutils
RUN ../${BINUTILS_VERSION}/configure \
        --prefix=/opt/cross-pi-gcc --target=arm-linux-gnueabihf \
        --with-arch=armv6 --with-fpu=vfp --with-float=hard \
        --disable-multilib
RUN make -j$(nproc)
RUN make install

# Build the first part of GCC
WORKDIR /gcc-cross/build-gcc
RUN ../${GCC_VERSION}/configure \
        --prefix=/opt/cross-pi-gcc \
        --target=arm-linux-gnueabihf \
        --enable-languages=c,c++,fortran \
        --with-arch=armv6 --with-fpu=vfp --with-float=hard \
        --disable-multilib
RUN make -j$(nproc) 'LIMITS_H_TEST=true' all-gcc
RUN make install-gcc
ENV PATH=/opt/cross-pi-gcc/bin:${PATH}

# Download and install the Linux headers
WORKDIR /gcc-cross
RUN git clone --depth=1 https://github.com/raspberrypi/linux
WORKDIR /gcc-cross/linux
ENV KERNEL=kernel7
RUN make ARCH=arm INSTALL_HDR_PATH=/opt/cross-pi-gcc/arm-linux-gnueabihf headers_install

# Build GLIBC
WORKDIR /gcc-cross/${GLIBC_VERSION}
COPY glibc.patch .
RUN patch -p1 < glibc.patch
WORKDIR /gcc-cross/build-glibc
RUN ../${GLIBC_VERSION}/configure \
        --prefix=/opt/cross-pi-gcc/arm-linux-gnueabihf \
        --build=$MACHTYPE --host=arm-linux-gnueabihf --target=arm-linux-gnueabihf \
        --with-arch=armv6 --with-fpu=vfp --with-float=hard \
        --with-headers=/opt/cross-pi-gcc/arm-linux-gnueabihf/include \
        --disable-multilib libc_cv_forced_unwind=yes
RUN make install-bootstrap-headers=yes install-headers
RUN make -j8 csu/subdir_lib
RUN install csu/crt1.o csu/crti.o csu/crtn.o /opt/cross-pi-gcc/arm-linux-gnueabihf/lib
RUN arm-linux-gnueabihf-gcc -nostdlib -nostartfiles -shared -x c /dev/null \
        -o /opt/cross-pi-gcc/arm-linux-gnueabihf/lib/libc.so
RUN touch /opt/cross-pi-gcc/arm-linux-gnueabihf/include/gnu/stubs.h

# Continue building GCC
WORKDIR /gcc-cross/build-gcc
RUN make -j$(nproc) all-target-libgcc
RUN make install-target-libgcc

# Finish building GLIBC
WORKDIR /gcc-cross/build-glibc
RUN make -j$(nproc)
RUN make install

# Finish building GCC
WORKDIR /gcc-cross/build-gcc
RUN make -j$(nproc)
RUN make install
