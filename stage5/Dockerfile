FROM stage4

RUN yum -y install gmp-devel mpfr-devel libmpc-devel
RUN wget -q https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz && \
    tar xf gcc-10.2.0.tar.xz && \
    mkdir gcc-10.2.0-build && \
    rm gcc-*.tar.xz
WORKDIR gcc-10.2.0-build
RUN ../gcc-10.2.0/configure \
      --enable-languages=all \
      --enable-shared \
      --enable-threads=posix \
      --enable-__cxa_atexit \
      --enable-clocale=gnu \
      --disable-multilib \
      --with-float=hard \
      --prefix=/usr/local/gcc/10.2.0
RUN make && make install