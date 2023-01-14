FROM stage2

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
    pip3.11 install -U setuptools wheel

RUN ln -s /usr/local/bin/pip3.8 /usr/local/bin/pip
RUN pip install auditwheel
