FROM stage1

RUN wget -q https://www.python.org/ftp/python/3.7.16/Python-3.7.16.tgz && \
    tar xf Python-3.7.16.tgz && \
    cd Python-3.7.16 && \
    ./configure --enable-optimizations && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-3.7.16*
RUN wget -q https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tgz && \
    tar xf Python-3.8.16.tgz && \
    cd Python-3.8.16 && \
    ./configure --enable-optimizations && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-3.8.16*
RUN wget -q https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz && \
    tar xf Python-3.9.16.tgz && \
    cd Python-3.9.16 && \
    ./configure --enable-optimizations && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-3.9.16*
RUN wget -q https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz && \
    tar xf Python-3.10.9.tgz && \
    cd Python-3.10.9 && \
    ./configure --enable-optimizations && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-3.10.9*
RUN wget -q https://www.python.org/ftp/python/3.11.1/Python-3.11.1.tgz && \
    tar xf Python-3.11.1.tgz && \
    cd Python-3.11.1 && \
    ./configure --enable-optimizations && \
    make -j4 altinstall && \
    cd .. && \
    rm -rf Python-3.11.1*
