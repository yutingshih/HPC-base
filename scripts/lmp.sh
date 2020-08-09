#!/bin/bash
# Author: Yuting Shih
# Date: 2020-07-04 Sat.
# Desc: build LAMMPS for testing

git clone -b stable https://github.com/lammps/lammps.git lammps
cd lammps
mkdir build
cd build
cmake ../cmake

cmake --build .
make -j $(nproc)

# make install
lmp -help


git clone -b stable https://github.com/lammps/lammps.git lammps
mkdir lammps/build
cd lammps/build
cmake ../cmake
make -j $(nproc)
make install
lmp -help