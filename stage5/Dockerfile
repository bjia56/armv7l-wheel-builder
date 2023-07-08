FROM stage4

RUN yum -y install gmp-devel mpfr-devel libmpc-devel
RUN wget -q https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz && \
    tar xf gcc-10.2.0.tar.xz && \
    mkdir gcc-10.2.0-build
WORKDIR gcc-10.2.0-build
RUN ../gcc-10.2.0/configure --enable-languages=c,c++,fortran \
    --disable-multilib --prefix=/usr/local/gcc/10.2.0
RUN make && make install