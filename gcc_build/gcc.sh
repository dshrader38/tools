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

#Libraries have been installed in:
#   /usr/local/gcc-4.9.2/lib

#If you ever happen to want to link against installed libraries
#in a given directory, LIBDIR, you must either use libtool, and
#specify the full pathname of the library, or use the `-LLIBDIR'
#flag during linking and do at least one of the following:
#   - add LIBDIR to the `DYLD_LIBRARY_PATH' environment variable
#     during execution

#See any operating system documentation about shared libraries for
#more information, such as the ld(1) and ld.so(8) manual pages.
