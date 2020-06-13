#!/bin/bash
# Author: Yuting Shih
# Date: 2020-06-11 Thu.
# Desc: install GCC from source codes

function setup_gcc() {
	MAJOR=${1}
	MINOR=${2}
	MICRO=${3}

	APP_NAME=gcc-${MAJOR}.${MINOR}.${MICRO}
	SRC_DIR=${SOURCE_DIR}/${APP_NAME}
	BUILD_DIR=${SOURCE_DIR}/${APP_NAME}-build
	GCC_URL=https://bigsearcher.com/mirrors/gcc/releases/${APP_NAME}/${APP_NAME}.tar.gz
}

function download_gcc() {
	setup_gcc ${1} ${2} ${3}
	wget ${GCC_URL} -O - | tar -xzC ${SOURCE_DIR}
}

function install_gcc() {
	setup_gcc ${1} ${2} ${3}
	unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE
	
	# install prerequisites
	cd ${SRC_DIR} && ${SRC_DIR}/contrib/download_prerequisites

	# configure & compile
	module purge

	mkdir ${BUILD_DIR} && cd ${BUILD_DIR}
	${SRC_DIR}/configure --prefix=/usr/local/${APP_NAME} \
		--enable-threads=posix --disable-checking --disable-multilib
	make -j $(nproc)
	make install -j $(nproc)
	
	cd ${TOPDIR}
}

function build_gcc() {
	download_gcc ${1} ${2} ${3}
	install_gcc ${1} ${2} ${3}
}