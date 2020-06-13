#!/bin/bash
# Author: Yuting Shih
# Date: 2020-06-13 Sat.
# Desc: install Intel MPI 2020.0.166

function install_impi() {
	TOPDIR=/root
	CODE_NAME=parallel_studio_xe_2020_cluster_edition
	APP_DIR=${SOURCE_DIR}/${CODE_NAME}
	TAR_FILE=${SOURCE_DIR}/${CODE_NAME}.tgz
	INTEL_SN=${SOURCE_DIR}/intel_sn

	tar -zxf ${TAR_FILE} -C ${SOURCE_DIR}
	cd ${APP_DIR}
	sed -ine 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/' silent.cfg
	sed -ine 's/ARCH_SELECTED=ALL/ARCH_SELECTED=INTEL64/' silent.cfg
	sed -inre "s/\#ACTIVATION_SERIAL_NUMBER=snpat/ACTIVATION_SERIAL_NUMBER=$(cat ${INTEL_SN})/" silent.cfg
	sed -ine 's/ACTIVATION_TYPE=exist_lic/ACTIVATION_TYPE=serial_number/' silent.cfg
	./install.sh --silent silent.cfg
	rm ${INTEL_SN}
	cd ${TOPDIR}
}

function build_impi() {
	install_impi
}