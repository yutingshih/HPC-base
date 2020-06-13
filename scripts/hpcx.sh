#!/bin/bash
# Author: Yuting Shih
# Date: 2020-06-13 Sat.
# Desc: install HPC-X

download_hpcx() {
	URL=http://content.mellanox.com/hpc/hpc-x/v2.6/hpcx-v2.6.0-gcc-MLNX_OFED_LINUX-4.7-1.0.0.1-ubuntu16.04-x86_64.tbz
	wget ${URL} -O - | tar -xjC ${SOURCE_DIR}
}

build_hpcx() {
	download_hpcx
}