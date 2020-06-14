# Author: Yuting Shih
# Date: 2020-06-13 Sat.
# Desc: build base image for HPC applications

FROM ubuntu:16.04
SHELL ["/bin/bash", "-c"]
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
	vim tmux locate environment-modules tcl python3 python3-pip \
	git wget curl ssh net-tools \
	gcc g++ gfortran make cmake autoconf automake \
	libgtk2.*common libpango-1* libasound2* xserver-xorg cpio

ENV TOPDIR=/root
ENV SCRIPT_DIR=${TOPDIR}/scripts \
	MODULE_DIR=${TOPDIR}/modules \
	SOURCE_DIR=${TOPDIR}/sources \
	SET_SCRIPT='for file in $(ls ${SCRIPT_DIR}/*.sh); do source $file; done' \
	SET_MODULE='source /etc/profile.d/modules.sh'

COPY scripts ${SCRIPT_DIR}
COPY modules ${MODULE_DIR}

RUN echo ${SET_SCRIPT} >> ~/.bashrc && echo ${SET_MODULE} >> ~/.bashrc

CMD eval ${SET_MODULE} && module use ${MODULE_DIR}; bash