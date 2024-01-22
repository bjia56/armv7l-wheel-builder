#!/bin/bash

set -x

yum install -y rpmdevtools

git clone https://git.centos.org/rpms/devtoolset-10-binutils.git ~/rpmbuild
( cd ~/rpmbuild && git checkout 4062e1df70e99d2705abf4cf381ac62af9c856d1 )
wget https://ftp.gnu.org/gnu/binutils/binutils-2.35.tar.xz -O ~/rpmbuild/SOURCES/doxygen-1.8.0.src.tar.gz
touch ~/rpmbuild/SOURCES/standards.info.gz

spectool -g -R ~/rpmbuild/SPECS/binutils.spec
yum install -y $(rpmbuild -bb ~/rpmbuild/SPECS/binutils.spec 2>&1 | fgrep 'is needed by' | awk '{print $1}')
rpmbuild -bb ~/rpmbuild/SPECS/binutils.spec
