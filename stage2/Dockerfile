FROM stage1

RUN pip3.8 install cmake==3.25.2 --extra-index-url https://bjia56.github.io/armv7l-wheels/
RUN pip3.8 install ninja==1.11.1.1 --extra-index-url https://bjia56.github.io/armv7l-wheels/

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

RUN pip3.7 install -U setuptools wheel packaging && \
    pip3.8 install -U setuptools wheel packaging && \
    pip3.9 install -U setuptools wheel packaging && \
    pip3.10 install -U setuptools wheel packaging && \
    pip3.11 install -U setuptools wheel packaging && \
    pip3.12 install -U setuptools wheel packaging

RUN ln -s /usr/local/bin/pip3.8 /usr/local/bin/pip
RUN pip install auditwheel

RUN wget -q https://go.dev/dl/go1.19.10.linux-armv6l.tar.gz && \
    tar -C /usr/local -xzf go1.19.10.linux-armv6l.tar.gz && \
    rm go1.19.10.linux-armv6l.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

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
