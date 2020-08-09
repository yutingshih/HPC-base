#!/bin/bash
# Author: Yuting Shih
# Date: 2020-06-13 Sat.
# Desc: install software in one command

# Usage:
# 	source app.sh
# 	app <command> [option] <packages>
# 
# Commands:
# 	get			download packages
# 	build		build packages
# 	install		download and build packages
# 	test		test packages
# 	help		print help message
# 
# Options:
# 	-v VERSION
# 	-c COMPILER

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

function app_get() {

}

function app_build() {

}

function app_install() {

}

function app_test() {

}

# while [ $1 != '' ]; do
# 	case $1 in
# 		'get' )
# 			shift
# 		-c | --compiler )
# 			shift
# 			CC=$1
# 			;;
# 		-h | --help )
# 			usage
# 			exit
# 			;;
# 		* )
# 			usage
# 			exit 1

# 	esac
# done