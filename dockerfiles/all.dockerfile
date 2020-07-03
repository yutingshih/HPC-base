# Author: Yuting Shih
# Date: 2020-07-03 Fri.
# Desc: image derived from HPC-base for HPC applications

FROM tings0802/hpc-base:0.5
SHELL ["/bin/bash", "-c"]
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive

COPY scripts ${SCRIPT_DIR}
COPY modules ${MODULE_DIR}
COPY sources ${SOURCE_DIR}

RUN eval ${SET_SCRIPT} && eval ${SET_MODULE} && \
    install_gcc 8 4 0; install_ompi 4 0 3; install_impi; \
    intel_modules; fftw get; fftw build --all

CMD eval ${SET_MODULE}; bash