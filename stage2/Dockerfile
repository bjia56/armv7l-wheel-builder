FROM stage1

RUN wget -q https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1.tar.gz && \
    tar xf cmake-3.25.1.tar.gz && \
    cd cmake-3.25.1 && \
    ./bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_PREFIX_PATH=/usr/local/ssl && \
    make -j4 && \
    make install && \
    cd .. && \
    rm -rf cmake-3.25.1*

RUN wget -q https://github.com/ninja-build/ninja/archive/refs/tags/v1.11.1.tar.gz && \
    tar xvf v1.11.1.tar.gz && \
    cd ninja-1.11.1 && \
    python3.8 ./configure.py --bootstrap && \
    mv ninja /usr/local/bin && \
    cd .. && \
    rm -rf ninja-1.11.1* && \
    rm -rf v1.11.1*

RUN wget -q https://github.com/NixOS/patchelf/releases/download/0.17.0/patchelf-0.17.0-armv7l.tar.gz && \
    tar xf patchelf-0.17.0-armv7l.tar.gz -C /usr/local/ && \
    rm -rf patchelf-0.17.0*

RUN wget -q https://static.rust-lang.org/rustup/dist/armv7-unknown-linux-gnueabihf/rustup-init && \
    chmod +x rustup-init && \
    ./rustup-init -y
ENV PATH=$PATH:/root/.cargo/bin

RUN pip3.8 install certifi && \
    certs=$(python3.8 -c 'import certifi; print(certifi.where())') && \
    echo $certs && \
    mkdir -p /opt/_internal && \
    ln -s $certs /opt/_internal/certs.pem
ENV SSL_CERT_FILE=/opt/_internal/certs.pem

RUN pip3.7 install -U setuptools wheel && \
    pip3.8 install -U setuptools wheel && \
    pip3.9 install -U setuptools wheel && \
    pip3.10 install -U setuptools wheel && \
    pip3.11 install -U setuptools wheel && \
    pip3.12 install -U setuptools wheel

RUN ln -s /usr/local/bin/pip3.8 /usr/local/bin/pip
RUN pip install auditwheel

RUN wget -q https://go.dev/dl/go1.19.10.linux-armv6l.tar.gz && \
    tar -C /usr/local -xzf go1.19.10.linux-armv6l.tar.gz && \
    rm go1.19.10.linux-armv6l.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

RUN wget -q https://github.com/bjia56/armv7l-wheel-builder/releases/download/devtoolset-10-1/devtoolset-10.tar.gz && \
    tar -C / -xzf devtoolset-10.tar.gz && \
    rm devtoolset-10.tar.gz

RUN wget -q https://github.com/bjia56/armv7l-wheel-builder/releases/download/devtoolset-10-binutils-1/binutils-2.35-5.el7.4.armv7hl.rpm && \
    yum install -y binutils*.rpm && \
    cd /opt/rh/devtoolset-10/root/ && \
    rpm2cpio /binutils*.rpm | cpio -idmv && \
    ln -s /opt/rh/devtoolset-10/root/usr/bin/ld.bfd /opt/rh/devtoolset-10/root/usr/bin/ld && \
    rm /binutils*.rpm

RUN wget -q https://github.com/bjia56/armv7l-wheel-builder/releases/download/cross-pi-gcc-10-1/cross-pi-gcc.tar.gz && \
    tar -C / -xzf cross-pi-gcc.tar.gz && \
    rm cross-pi-gcc.tar.gz

RUN wget -q https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.45.1.tar.gz && \
    yum -y install libcurl-devel && \
    tar xf git-2.45.1.tar.gz && \
    cd git-2.45.1 && \
    export PATH=/opt/rh/devtoolset-10/root/usr/bin:$PATH && \
    make configure && \
    ./configure --prefix=/usr/local && \
    make -j4 && \
    make install && \
    rm -rf git-2.45.1*

COPY select_python /usr/local/bin/select_python
COPY select_go /usr/local/bin/select_go
