# Author: Yuting Shih
# Date: 2020-07-04 Sat.
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
	SOURCE_DIR=${TOPDIR}/sources

COPY scripts ${SCRIPT_DIR}
COPY modules ${MODULE_DIR}
COPY sources ${SOURCE_DIR}

ENV SET_SCRIPT='for file in $(ls ${SCRIPT_DIR}/*.sh); do source $file; done' \
	SET_MODULE='source /etc/profile.d/modules.sh && module use ${MODULE_DIR}'
RUN printf "\n${SET_SCRIPT}\n${SET_MODULE}" >> ~/.bashrc

RUN eval ${SET_SCRIPT} && eval ${SET_MODULE} && \
	install_gcc 8 4 0; install_ompi 4 0 3; install_impi; \
    intel_modules; fftw get; fftw build --all

CMD eval ${SET_MODULE}; bash