#! /bin/bash

VERSION=4.9.2
PREFIX=/usr/local/gcc-$VERSION
LANGUAGES=c,c++,fortran
MAKE='make -j 4' # to compile using four cores

brew-path() { brew info $1 | head -n3 | tail -n1 | cut -d' ' -f1; }

# Prerequisites

brew install gmp
brew install mpfr
brew install libmpc

# Download & install the latest GCC

mkdir -p $PREFIX
mkdir -p temp-gcc-$VERSION
cd temp-gcc-$VERSION
if [ "$1" = "-d" ]
    then
        wget ftp://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.gz
        tar xfz gcc-$VERSION.tar.gz
fi

cd gcc-$VERSION

mkdir build
cd build

../configure \
     --prefix=$PREFIX \
     --with-gmp=$(brew-path gmp) \
     --with-mpfr=$(brew-path mpfr) \
     --with-mpc=$(brew-path libmpc) \
     --program-suffix=-$VERSION \
     --enable-languages=$LANGUAGES \
     --with-system-zlib \
     --enable-stage1-checking \
     --enable-plugin \
     --enable-lto \
     --disable-multilib

$MAKE bootstrap
make install

# Uncomment for cleanup …
cd ../../..
# rm -rf temp-gcc-$VERSION
