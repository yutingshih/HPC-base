#!/bin/bash
# Author: Yuting Shih
# Date: 2020-07-02 Thu.
# Desc: build FFTW 3.3.8 shared library (single precision) with GCC and ICC

# Usage:
# 	source fftw.sh
# 	fftw <command> [option]

# commands:
# 	get		: download and untar
# 	build	: build FFTW with GCC or ICC
# 	rebuild	: remove FFTW and untar again
# 	test	: test FFTW with its bench executable

# options:
# 	--gcc	: build FFTW with GCC compiler
# 	--icc	: build FFTW with ICC compiler
# 	--all	: build FFTW with both GCC and ICC compiler

# Example:
# 	source fftw.sh
# 	fftw get
#	fftw build --all
#	fftw run --all

VER=3.3.8
BASE=${TOPDIR:-${HOME}}
CODE_DIR=${BASE}/fftw-${VER}
INSTALL_DIR=${BASE}/fftw
TAR_FILE=fftw-${VER}.tar.gz
GCC_LABEL=${VER}-shared-gcc840-avx2-broadwell
ICC_LABEL=${VER}-shared-icc20-avx2-broadwell

CMAKE=/usr/bin/cmake
GCC=/usr/local/gcc-8.4.0/bin/gcc
ICC=/opt/intel/compilers_and_libraries_2020.0.166/linux/bin/intel64/icc

NATIVE_GCC_FLAGS='"-march=native -mtune=native -mavx2 -msse4.2 -O3 -DNDEBUG"'
GCC_FLAGS='"-march=broadwell -mtune=broadwell -mavx2 -msse4.2 -O3 -DNDEBUG"'
ICC_FLAGS='"-xBROADWELL -axBROADWELL,CORE-AVX2,SSE4.2 -O3 -DNDEBUG"'

function getfftw() {
	wget -P ${BASE} http://www.fftw.org/${TAR_FILE}
	tar -zxf ${BASE}/${TAR_FILE} -C ${BASE}
}

function rebuildfftw() {
	rm -fr $CODE_DIR && tar -zxf ${BASE}/${TAR_FILE} -C ${BASE}
}

function buildfftw() {
	CC=${1:-${GCC}}
	CC_FLAGS=${2:-${GCC_FLAGS}}

	if [[ ${CC:(-3):3} == gcc ]]; then
		BUILD_LABEL=${GCC_LABEL}
	elif [[ ${CC:(-3):3} == icc ]]; then
		BUILD_LABEL=${ICC_LABEL}
	else
		echo "compiler not found"
		exit 1;
	fi

	BUILD_CMD=" \
	mkdir -p ${CODE_DIR}/build-${BUILD_LABEL}; \
	cd ${CODE_DIR}/build-${BUILD_LABEL} \
	&& ${CMAKE} \
	-DBUILD_SHARED_LIBS=ON	-DENABLE_FLOAT=ON \
	-DENABLE_OPENMP=OFF -DENABLE_THREADS=OFF \
	-DCMAKE_C_COMPILER=${CC} -DCMAKE_CXX_COMPILER=${CC} \
	-DENABLE_AVX2=ON -DENABLE_AVX=ON \
	-DENABLE_SSE2=ON -DENABLE_SSE=ON \
	-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/${BUILD_LABEL} \
	-DCMAKE_C_FLAGS_RELEASE=${CC_FLAGS} \
	-DCMAKE_CXX_FLAGS_RELEASE=${CC_FLAGS} .. \
	&& make VERBOSE=1 V=1 install -j \
	&& cd ${INSTALL_DIR}/${BUILD_LABEL} \
	&& ln -s lib64 lib | tee ${BUILD_LABEL}.log"
	eval $BUILD_CMD
}

function testfftw() {
	OPT=${1}
	SIZE=${2:-1024}

	GCC_BENCH="${CODE_DIR}/build-${GCC_LABEL}/bench -o patient ${SIZE}"
	ICC_BENCH="${CODE_DIR}/build-${ICC_LABEL}/bench -o patient ${SIZE}"
	GCC_BENCH_NOSIMD="${CODE_DIR}/build-${GCC_LABEL}/bench -o patient -o nosimd ${SIZE}"
	ICC_BENCH_NOSIMD="${CODE_DIR}/build-${ICC_LABEL}/bench -o patient -o nosimd ${SIZE}"
	
	if [[ ${OPT} == '--gcc' ]]; then
		echo ${GCC_BENCH}
		eval ${GCC_BENCH}
	elif [[ ${OPT} == '--icc' ]]; then
		module purge; module load impi
		echo ${ICC_BENCH}
		eval ${ICC_BENCH}
	elif [[ ${OPT} == '--all' ]]; then
		module purge; module load impi
		echo ${GCC_BENCH}
		eval ${GCC_BENCH}
		echo ${ICC_BENCH}
		eval ${ICC_BENCH}
	else
		echo "testfftw: ${OPT} option not found"
		exit 1;
	fi
}

function fftw() {
	CMD=${1:-'get'}
	OPT=${2:-'--all'}
	VAL=${3}

	if [[ ${CMD} == get ]]; then
		getfftw
	elif [[ ${CMD} == rebuild ]]; then
		rebuildfftw
	elif [[ ${CMD} == build ]]; then
		if [[ ${OPT} == '--gcc' || ${OPT} == '--all' ]]; then buildfftw ${GCC} ${GCC_FLAGS}; fi
		if [[ ${OPT} == '--icc' || ${OPT} == '--all' ]]; then buildfftw ${ICC} ${ICC_FLAGS}; fi
	elif [[ ${CMD} == run ]]; then
		testfftw ${OPT} ${VAL}
	else
		echo "fftw: ${CMD}: command not found"
		exit 1;
	fi
}