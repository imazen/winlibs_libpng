#!/bin/bash
# set $1 to 1 to force an x86 build
# set $2 to 1 to rebuild and statically link any deps
# ex: _build 0 1 would build an x64 static (on x64 machines)

_build()
{
  echo "*building* (x86=${1-0}; static=${2-0})"
  
  pack="*.a *.so*"
  cmargs="-DCMAKE_C_FLAGS=-fPIC"
  [ ${1-0} -gt 0 ] && cmargs="$cmargs -DCMAKE_C_FLAGS=-m32"
  
  if [ ${2-0} -gt 0 ]; then
    mkdir deps
    git clone https://github.com/imazen/zlib
    cd zlib
    cmake -G "Unix Makefiles" $cmargs
    make zlib_static
    cp libz.a ../deps
    cp *.h ../deps
    cd ..
    cmargs="$cmargs -DCMAKE_PREFIX_PATH=$(pwd)/deps"
    pack="$pack deps/*.a"
  fi
  
  cmake -G "Unix Makefiles" $cmargs
  make
  ctest .
  objdump -f *.so | grep ^architecture
  ldd *.so
  find . -maxdepth 1 -type l -exec rm -f {} \;
  tar -zcf binaries.tar.gz $pack
}


_clean()
{
  echo "*cleaning*"
  git clean -ffde /out > /dev/null
  git reset --hard > /dev/null
}

mkdir out

_build
mv binaries.tar.gz out/libpng-x64.tar.gz
_clean

_build 0 1
mv binaries.tar.gz out/libpng-static-x64.tar.gz
_clean

sudo apt-get -y update > /dev/null
sudo apt-get -y install gcc-multilib > /dev/null
sudo ldconfig -n /lib/i386-linux-gnu/
for f in $(find /lib/i386-linux-gnu/*.so.*); do sudo ln -s -f $f ${f%%.*}.so; done > /dev/null

_build 1
mv binaries.tar.gz out/libpng-x86.tar.gz
_clean

_build 1 1
mv binaries.tar.gz out/libpng-static-x86.tar.gz
_clean
