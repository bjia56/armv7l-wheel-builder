FROM stage2

## ENV adapted from:
## https://github.com/pypa/manylinux/blob/0d3846337cef6977dead88453daae63d44f1ea5b/docker/build_scripts/build_utils.sh#L8-L11
ENV MANYLINUX_CPPFLAGS="-D_FORTIFY_SOURCE=2"
ENV MANYLINUX_CFLAGS="-g -O2 -Wall -fdebug-prefix-map=/=. -fstack-protector-strong -Wformat -Werror=format-security"
ENV MANYLINUX_CXXFLAGS="-g -O2 -Wall -fdebug-prefix-map=/=. -fstack-protector-strong -Wformat -Werror=format-security"
ENV MANYLINUX_LDFLAGS="-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now"
RUN yum erase -y openssl-devel && \
    wget https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1s.tar.gz && \
    tar xf OpenSSL_1_1_1s.tar.gz && \
    cd openssl-OpenSSL_1_1_1s && \
    ./config no-shared no-asm --prefix=/usr/local/ssl --openssldir=/usr/local/ssl CPPFLAGS="${MANYLINUX_CPPFLAGS}" CFLAGS="${MANYLINUX_CFLAGS} -fPIC" CXXFLAGS="${MANYLINUX_CXXFLAGS} -fPIC" LDFLAGS="${MANYLINUX_LDFLAGS} -fPIC" && \
    make && \
    make install_sw && \
    cd .. && \
    rm -rf openssl-OpenSSL_1_1_1s* && \
    rm -rf OpenSSL_1_1_1s*

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
