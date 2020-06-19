#!/bin/bash

ELMER_SOURCE_HOME=$(pwd)

command_exists () {
    type "$1" &> /dev/null ;
}

DOWNLOAD_TOOL=wget

if command_exists axel ; then
	DOWNLOAD_TOOL=axel
fi

echo "Download with ${DOWNLOAD_TOOL}"

# test download
# $DOWNLOAD_TOOL www.baidu.com

ELMER_SOURCE='https://github.com/ElmerCSC/elmerfem/archive/scc20.tar.gz'

if [ -f elmerfem-scc20.tar.gz ]; then
	echo "Already Downloaded Elmer Source"
else
	echo "Downloading Elmer Source"
	$DOWNLOAD_TOOL $ELMER_SOURCE
fi

if [ -d tools ]; then
	echo "Already Build Tools Directory"
else
	echo "Making a new Directory"
	mkdir -p tools
fi

if [ -d elmerfem-scc20 ]; then
	echo "Alreay Unpacked(Elmer Source)"
else
	echo "Unpacking(Elmer Source) ..."
	tar -xzvf elmerfem-scc20.tar.gz
fi

# --------------------------------------------------------------------------- #
# Going to Third-Party Tools Directory #
# --------------------------------------------------------------------------- #

if [ -d elmer_lib ]; then
	echo "Already built a dir for 3rd-party lib install."
else
	echo "Prepareing dir to install 3rd-party lib..."
fi

mkdir -p elmer_lib

cd tools

# 3rd-Party Lib Source List
CMAKE_SOURCE='https://github.com/Kitware/CMake/releases/download/v3.17.3/cmake-3.17.3.tar.gz'
ZLIB_SOURCE='https://www.zlib.net/zlib-1.2.11.tar.gz'
HDF5_SOURCE='https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_0/source/hdf5-1.12.0.tar.gz'
NETCDF_C_SOURCE='http://github.com/Unidata/netcdf-c'
NETCDF_FORTRAN_SOURCE='https://github.com/Unidata/netcdf-fortran.git'
MMG_SOURCE='https://github.com/MmgTools/mmg.git'
HYPRE_SOURCE='https://github.com/hypre-space/hypre.git'
IPM_SOURCE='https://sourceforge.net/projects/ipm-hpc/files/latest/download'

# Download Cmake
if [ -f cmake-3.17.3.tar.gz ]; then
	echo "Already Downloaded Cmake"
else
	echo "Downloading Cmake"
	$DOWNLOAD_TOOL $CMAKE_SOURCE
fi

if [ -d cmake-3.17.3 ]; then
	echo "Already Unpacked(Cmake)"
else
	echo "Unpacking(Cmake) ..."
	tar -xzvf cmake-3.17.3.tar.gz
fi

# Download Zlib
if [ -f zlib-1.2.11.tar.gz ]; then
	echo "Already Downloaded Zlib"
else
	echo "Downloading Zlib"
	$DOWNLOAD_TOOL $ZLIB_SOURCE
fi

if [ -d zlib-1.2.11 ]; then
	echo "Already Unpacked(Zlib)"
else
	echo "Unpacking(Zlib) ..."
	tar -xzvf zlib-1.2.11.tar.gz
fi

# Download HDF5
if [ -f hdf5-1.12.0.tar.gz ]; then
	echo "Already Downloaded HDF5"
else
	echo "Downloading HDF5"
	$DOWNLOAD_TOOL $HDF5_SOURCE
fi

if [ -d hdf5-1.12.0 ]; then
	echo "Already Unpacked(HDF5)"
else
	echo "Unpacking(HDF5) ..."
	tar -xzvf hdf5-1.12.0.tar.gz
fi

# Download NetCDF-{C & Fortran}
if [ -d netcdf-c ]; then
	echo "Already Cloned(NetCDF C)"
else
	echo "Cloning NetCDF C"
	git clone $NETCDF_C_SOURCE
fi

if [ -d netcdf-fortran ]; then
	echo "Already Cloned(NetCDF Fortran)"
else
	echo "Cloning NetCDF Fortran"
	git clone $NETCDF_FORTRAN_SOURCE
fi

# Download MMG-LIB
if [ -d mmg ]; then
	echo "Already Cloned(MMG)"
else
	echo "Cloning MMG"
	git clone $MMG_SOURCE
fi

# Download Hypre
if [ -d hypre ]; then
	echo "Already Cloned(Hypre)"
else
	echo "Cloning Hypre"
	git clone $HYPRE_SOURCE
fi

# Download IPM
if [ -f ipm_0.983.tgz ]; then
	echo "Already Downloaded(IPM)"
else
	echo "Downloading(IPM)..."
	$DOWNLOAD_TOOL $IPM_SOURCE
fi

