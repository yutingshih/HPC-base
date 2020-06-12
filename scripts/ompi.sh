#!/bin/bash
# Author: Yuting Shih
# Date: 2020-06-10 Wed.
# Desc: install OpenMPI of serveral versions

function setup_ompi() {
	MAJOR=${1}
	MINOR=${2}
	MICRO=${3}

	CODE_NAME=openmpi-${MAJOR}.${MINOR}.${MICRO}
	BUILD_DIR=${SOURCE_DIR}/${CODE_NAME}-build
	APP_DIR=${SOURCE_DIR}/${CODE_NAME}
	URL=https://download.open-mpi.org/release/open-mpi/v${MAJOR}.${MINOR}/${CODE_NAME}.tar.gz
}

function download_ompi() {
	setup_ompi ${1} ${2} ${3}
	wget ${URL} -O - | tar -zxC ${SOURCE_DIR}
	mv ${SOURCE_DIR}/${CODE_NAME} ${BUILD_DIR}
}

function install_ompi() {
	setup_ompi ${1} ${2} ${3}
	
	module purge

	mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
	./configure --prefix=${APP_DIR}
	make -j $(nproc)
	make install -j $(nproc)

	cd ${TOPDIR}
}


# download_ompi 4 0 3
# download_ompi 3 1 6
# download_ompi 3 0 6

# install_ompi 4 0 3
# install_ompi 3 1 6
# install_ompi 3 0 6