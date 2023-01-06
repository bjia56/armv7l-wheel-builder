FROM stage1

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
ENV PATH=$PATH:/root/.cargo/bin
