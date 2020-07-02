#!/bin/bash
# Author: Yuting Shih
# Date: 2020-07-02 Thu.
# Desc: create modulefiles for Intel C Compiler, Intel MKL, and Intel MPI

INSTALL_DIR=/root/sources/env2-code
git clone https://git.code.sf.net/p/env2/code ${INSTALL_DIR}

echo "#%Module" > /usr/share/modules/modulefiles/icc
perl ${INSTALL_DIR}/env2 -from bash -to modulecmd \
"/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh intel64" >> /usr/share/modules/modulefiles/icc

echo "#%Module" > /usr/share/modules/modulefiles/mkl
perl ${INSTALL_DIR}/env2 -from bash -to modulecmd \
"/opt/intel/compilers_and_libraries_2020.0.166/linux/mkl/bin/mklvars.sh intel64" >> /usr/share/modules/modulefiles/mkl

echo "#%Module" > /usr/share/modules/modulefiles/impi
perl ${INSTALL_DIR}/env2 -from bash -to modulecmd \
"/opt/intel/compilers_and_libraries_2020.0.166/linux/mpi/intel64/bin/mpivars.sh" >> /usr/share/modules/modulefiles/impi