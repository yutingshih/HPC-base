#!/bin/bash
# Author: Yuting Shih
# Date: 2020-06-13 Sat.
# Desc: install software in one command

function build() {
	for file in $(ls ${SCRIPT_DIR}/*.sh); do source $file; done
	if [ $1 = gcc ]; then
		download_gcc $2 $3 $4 && install_gcc $2 $3 $4
	elif [ $1 = ompi ]; then
		download_ompi $2 $3 $4 && install_ompi $2 $3 $4
	elif [ $1 = impi ]; then
		install_impi
	elif [ $1 = hpcx ]; then
		download_hpcx
	fi
}