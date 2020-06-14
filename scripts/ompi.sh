#!/bin/bash
# Author: Yuting Shih
# Date: 2020-06-12 Fri.
# Desc: install OpenMPI of serveral versions

function prepare_ompi() {
	MAJOR=${1}
	MINOR=${2}
	MICRO=${3}

	CODE_NAME=openmpi-${MAJOR}.${MINOR}.${MICRO}
	BUILD_DIR=${SOURCE_DIR}/${CODE_NAME}
	APP_DIR=${SOURCE_DIR}/ompi-${MAJOR}.${MINOR}.${MICRO}
	URL=https://download.open-mpi.org/release/open-mpi/v${MAJOR}.${MINOR}/${CODE_NAME}.tar.gz
}

function download_ompi() {
	prepare_ompi ${1} ${2} ${3}
	wget ${URL} -O - | tar -zxC ${SOURCE_DIR}
}

function install_ompi() {
	prepare_ompi ${1} ${2} ${3}
	
	module purge

	mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
	./configure --prefix=${APP_DIR}
	make -j $(nproc)
	make install -j $(nproc)

	cd ${TOPDIR}
}

function build_ompi() {
	download_ompi ${1} ${2} ${3}
	install_ompi ${1} ${2} ${3}
}