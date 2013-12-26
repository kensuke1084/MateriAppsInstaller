#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/../util.sh
. $SCRIPT_DIR/version.sh
set_prefix
set_build_dir

. $PREFIX_OPT/env.sh

# cd $BUILD_DIR
# rm -rf szip-$SZIP_VERSION
# if [ -f $HOME/source/szip-$SZIP_VERSION.tar.gz ]; then
#   check tar zxf $HOME/source/szip-$SZIP_VERSION.tar.gz
# else
#   check wget -O - http://www.hdfgroup.org/ftp/lib-external/szip/$SZIP_VERSION/src/szip-$SZIP_VERSION.tar.gz | tar zxf -
# fi
# cd szip-$SZIP_VERSION
# CC=xlc CXX=xlC CFLAGS="-O2" CXXFLAGS="-O2" check ./configure --prefix=$PREFIX_OPT
# check gmake -j2
# $SUDO gmake install
# check gmake distclean
# CC=xlc CXX=xlC CFLAGS="-O2 -qpic" CXXFLAGS="-O2 -qpic" check ./configure --prefix=$PREFIX_OPT
# check gmake -j2
# check xlc -G -o libsz.so src/rice.o src/sz_api.o src/encoding.o
# $SUDO cp -fp libsz.so $PREFIX_OPT/lib

cd $BUILD_DIR
rm -rf hdf5-$HDF5_VERSION
if [ -f $HOME/source/hdf5-$HDF5_VERSION.tar.bz2 ]; then
  check tar jxf $HOME/source/hdf5-$HDF5_VERSION.tar.bz2
else
  check wget -O - http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.bz2
fi
cd hdf5-$HDF5_VERSION
CC=xlc CXX=xlC CFLAGS="-O2" CXXFLAGS="-O2" check ./configure --prefix=$PREFIX_OPT --with-szlib=$PREFIX_OPT
check gmake -j2
$SUDO gmake install
gmake distclean
CC=xlc CXX=xlC CFLAGS="-O2 -qpic" CXXFLAGS="-O2 -qpic" check ./configure --prefix=$PREFIX_OPT --with-szlib=$PREFIX_OPT
cd src
gmake -j2
xlc -G -o libhdf5.so H5.o H5checksum.o H5dbg.o H5lib_settings.o H5system.o H5timer.o H5trace.o H5[A-Z]*.o
$SUDO cp -fp libhdf5.so $PREFIX_OPT/lib
cd ../hl/src
make -j2
xlc -G -o libhdf5_hl.so H5*.o
$SUDO cp -fp libhdf5_hl.so $PREFIX_OPT/lib