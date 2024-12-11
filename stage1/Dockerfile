FROM centos:7

ARG PYTHON_37_VER=3.7.17
ARG PYTHON_38_VER=3.8.20
ARG PYTHON_39_VER=3.9.21
ARG PYTHON_310_VER=3.10.16
ARG PYTHON_311_VER=3.11.11
ARG PYTHON_312_VER=3.12.8
ARG PYTHON_313_VER=3.13.1

RUN echo "armhfp" > /etc/yum/vars/basearch && \
    echo "armv7hl" > /etc/yum/vars/arch && \
    echo "armv7hl-redhat-linux-gpu" > /etc/rpm/platform

RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf && \
    sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/*.repo && \
    sed -i 's;^.*baseurl=http://mirror;baseurl=https://vault;g' /etc/yum.repos.d/*.repo && \
    sed -i 's;/centos/7/;/altarch/7/;g' /etc/yum.repos.d/*.repo

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

RUN wget -q https://www.python.org/ftp/python/${PYTHON_37_VER}/Python-${PYTHON_37_VER}.tgz && \
    tar xf Python-${PYTHON_37_VER}.tgz && \
    cd Python-${PYTHON_37_VER} && \
    ./configure --with-lto=yes && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_37_VER}*
RUN wget -q https://www.python.org/ftp/python/${PYTHON_38_VER}/Python-${PYTHON_38_VER}.tgz && \
    tar xf Python-${PYTHON_38_VER}.tgz && \
    cd Python-${PYTHON_38_VER} && \
    ./configure --with-lto=yes && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_38_VER}*
RUN wget -q https://www.python.org/ftp/python/${PYTHON_39_VER}/Python-${PYTHON_39_VER}.tgz && \
    tar xf Python-${PYTHON_39_VER}.tgz && \
    cd Python-${PYTHON_39_VER} && \
    ./configure --with-lto=yes && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_39_VER}*
RUN wget -q https://www.python.org/ftp/python/${PYTHON_310_VER}/Python-${PYTHON_310_VER}.tgz && \
    tar xf Python-${PYTHON_310_VER}.tgz && \
    cd Python-${PYTHON_310_VER} && \
    ./configure --with-lto=yes && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_310_VER}*
RUN wget -q https://www.python.org/ftp/python/${PYTHON_311_VER}/Python-${PYTHON_311_VER}.tgz && \
    tar xf Python-${PYTHON_311_VER}.tgz && \
    cd Python-${PYTHON_311_VER} && \
    ./configure --with-lto=yes && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_311_VER}*
RUN wget -q https://www.python.org/ftp/python/${PYTHON_312_VER}/Python-${PYTHON_312_VER}.tgz && \
    tar xf Python-${PYTHON_312_VER}.tgz && \
    cd Python-${PYTHON_312_VER} && \
    ./configure --with-lto=yes && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_312_VER}*
RUN wget -q https://www.python.org/ftp/python/${PYTHON_313_VER}/Python-${PYTHON_313_VER}.tgz && \
    tar xf Python-${PYTHON_313_VER}.tgz && \
    cd Python-${PYTHON_313_VER} && \
    ./configure --with-lto=yes && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-${PYTHON_313_VER}*
