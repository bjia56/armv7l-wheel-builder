FROM centos:7

RUN echo "armhfp" > /etc/yum/vars/basearch && \
    echo "armv7hl" > /etc/yum/vars/arch && \
    echo "armv7hl-redhat-linux-gpu" > /etc/rpm/platform

RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install bzip2-devel libffi-devel xz-devel zlib-devel && \
    yum -y install wget which git && \
    yum -y clean all && \
    rm -rf /var/cache

## ENV adapted from:
## https://github.com/pypa/manylinux/blob/0d3846337cef6977dead88453daae63d44f1ea5b/docker/build_scripts/build_utils.sh#L8-L11
ENV MANYLINUX_CPPFLAGS="-D_FORTIFY_SOURCE=2"
ENV MANYLINUX_CFLAGS="-g -O2 -Wall -fdebug-prefix-map=/=. -fstack-protector-strong -Wformat -Werror=format-security"
ENV MANYLINUX_CXXFLAGS="-g -O2 -Wall -fdebug-prefix-map=/=. -fstack-protector-strong -Wformat -Werror=format-security"
ENV MANYLINUX_LDFLAGS="-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now"
RUN wget https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1s.tar.gz && \
    tar xf OpenSSL_1_1_1s.tar.gz && \
    cd openssl-OpenSSL_1_1_1s && \
    ./config no-shared --prefix=/usr/local/ssl --openssldir=/usr/local/ssl CPPFLAGS="${MANYLINUX_CPPFLAGS}" CFLAGS="${MANYLINUX_CFLAGS} -fPIC" CXXFLAGS="${MANYLINUX_CXXFLAGS} -fPIC" LDFLAGS="${MANYLINUX_LDFLAGS} -fPIC" && \
    make -j4 && \
    make install_sw && \
    cd .. && \
    rm -rf openssl-OpenSSL_1_1_1s* && \
    rm -rf OpenSSL_1_1_1s*