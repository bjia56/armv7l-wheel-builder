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
