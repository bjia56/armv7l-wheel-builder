FROM stage3

RUN pip3.8 install certifi && \
    certs=$(python3.8 -c 'import certifi; print(certifi.where())') && \
    echo $certs && \
    mkdir -p /opt/_internal && \
    ln -s $certs /opt/_internal/certs.pem
ENV SSL_CERT_FILE=/opt/_internal/certs.pem

RUN pip3.7 install -U setuptools wheel pip && \
    pip3.8 install -U setuptools wheel pip && \
    pip3.9 install -U setuptools wheel pip && \
    pip3.10 install -U setuptools wheel pip && \
    pip3.11 install -U setuptools wheel pip

RUN ln -s /usr/local/bin/pip3.8 /usr/local/bin/pip
RUN pip install auditwheel

RUN wget https://go.dev/dl/go1.19.9.linux-armv6l.tar.gz && \
    tar -C /usr/local -xzf go1.19.9.linux-armv6l.tar.gz && \
    rm go1.19.9.linux-armv6l.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
