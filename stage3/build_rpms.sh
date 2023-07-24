#!/bin/bash

set -x

yum install -y rpmdevtools

git clone https://git.centos.org/rpms/devtoolset-10-gcc.git ~/rpmbuild
( cd ~/rpmbuild && git checkout 0b7449501f22f785e018d22f9ec87190e9c8773f )
wget https://github.com/doxygen/doxygen/archive/refs/tags/Release_1_8_0.tar.gz -O ~/rpmbuild/SOURCES/doxygen-1.8.0.src.tar.gz
wget https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz -O ~/rpmbuild/SOURCES/mpc-1.0.3.tar.gz

git clone --mirror git://gcc.gnu.org/git/gcc.git /tmp/gcc/.git
git --git-dir=/tmp/gcc/.git archive --prefix=gcc-10.2.1-20210130/ 966e4575ccd8b618811b4871e44c31bb2d11a82a | xz -9e > ~/rpmbuild/SOURCES/gcc-10.2.1-20210130.tar.xz

spectool -g -R ~/rpmbuild/SPECS/gcc.spec
yum install -y $(rpmbuild -bb ~/rpmbuild/SPECS/gcc.spec 2>&1 | fgrep 'is needed by' | awk '{print $1}')
rpmbuild -bb ~/rpmbuild/SPECS/gcc.spec
