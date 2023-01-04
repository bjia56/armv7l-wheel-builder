FROM centos:7

RUN echo "armhfp" > /etc/yum/vars/basearch && \
    echo "armv7hl" > /etc/yum/vars/arch && \
    echo "armv7hl-redhat-linux-gpu" > /etc/rpm/platform

RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install openssl-devel bzip2-devel libffi-devel xz-devel && \
    yum -y install wget which git

RUN wget -q https://www.python.org/ftp/python/3.7.16/Python-3.7.16.tgz && \
    tar xf Python-3.7.16.tgz && \
    cd Python-3.7.16 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.7.16*
RUN wget -q https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tgz && \
    tar xf Python-3.8.16.tgz && \
    cd Python-3.8.16 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.8.16*
RUN wget -q https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz && \
    tar xf Python-3.9.16.tgz && \
    cd Python-3.9.16 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.9.16*
RUN wget -q https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz && \
    tar xf Python-3.10.9.tgz && \
    cd Python-3.10.9 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.10.9*
RUN wget -q https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tgz && \
    tar xf Python-3.11.1.tgz && \
    cd Python-3.11.1 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.11.1*
RUN wget -q https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz && \
    tar xf Python-3.12.0.tgz && \
    cd Python-3.12.0 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.12.0*

RUN wget -q https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1.tar.gz && \
    tar xf cmake-3.25.1.tar.gz && \
    cd cmake-3.25.1 && \
    ./bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release && \
    make && \
    make install && \
    cd .. && \
    rm -rf cmake-3.25.1*

RUN wget https://github.com/ninja-build/ninja/archive/refs/tags/v1.11.1.tar.gz && \
    tar xvf v1.11.1.tar.gz && \
    cd ninja-1.11.1 && \
    python3.8 ./configure.py --bootstrap && \
    mv ninja /usr/local/bin && \
    cd .. && \
    rm -rf ninja-1.11.1* && \
    rm -rf v1.11.1*

RUN wget https://github.com/NixOS/patchelf/releases/download/0.17.0/patchelf-0.17.0-armv7l.tar.gz && \
    tar xf patchelf-0.17.0-armv7l.tar.gz -C /usr/local/ && \
    rm -rf patchelf-0.17.0*

RUN wget https://static.rust-lang.org/rustup/dist/armv7-unknown-linux-gnueabihf/rustup-init && \
    chmod +x rustup-init && \
    ./rustup-init -y
