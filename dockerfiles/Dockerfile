# Author: Yuting Shih
# Date: 2020-06-12 Fri.
# Desc: build base image for HPC applications

FROM ubuntu:16.04
SHELL ["/bin/bash", "-c"]
WORKDIR /root

RUN apt update && apt install -y \
	vim tmux locate environment-modules tcl python3 python3-pip \
	git wget curl ssh net-tools \
	gcc g++ gfortran make cmake autoconf automake

ENV TOPDIR=/root
ENV SCRIPT_DIR=${TOPDIR}/scripts \
	MODULE_DIR=${TOPDIR}/modules \
	SOURCE_DIR=${TOPDIR}/sources \
	SET_SCRIPT='for file in $(ls ${SCRIPT_DIR}/*.sh); do . $file; done'

COPY scripts ${SCRIPT_DIR}
COPY modules ${MODULE_DIR}
COPY sources ${SOURCE_DIR}

RUN echo ${SET_SCRIPT} >> ~/.bashrc

CMD source /etc/profile.d/modules.sh && \
	module use ${MODULE_DIR}; bash