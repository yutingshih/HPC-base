#!/bin/bash
# Author: Yuting Shih
# Date: 2020-07-02 Thu.
# Desc: create modulefiles for Intel C Compiler, Intel MKL, and Intel MPI

git clone https://git.code.sf.net/p/env2/code /root/sources/env2-code

echo "#%Module" > /usr/share/modules/modulefiles/icc
perl /root/env2-code/env2 -from bash -to modulecmd \
"/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh intel64" >> /usr/share/modules/modulefiles/icc

echo "#%Module" > /usr/share/modules/modulefiles/mkl
perl /root/env2-code/env2 -from bash -to modulecmd \
"/opt/intel/compilers_and_libraries_2020.0.166/linux/mkl/bin/mklvars.sh intel64" >> /usr/share/modules/modulefiles/mkl

echo "#%Module" > /usr/share/modules/modulefiles/impi
perl /root/env2-code/env2 -from bash -to modulecmd \
"/opt/intel/compilers_and_libraries_2020.0.166/linux/mpi/intel64/bin/mpivars.sh" >> /usr/share/modules/modulefiles/impi