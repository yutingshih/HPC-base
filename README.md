# HPC-base
Dockerfiles of base images for 2020 APAC HPCAI Competition

## Description
`dockerfiles/`: dockerfiles of the base image
`scripts/`: shell scripts to install softwares
`modules/`: modulefiles to manage the system environment
`sources/`: source codes to be install

## Usage
Clone this repository
```bash
git clone https://github.com/tings0802/HPC-base.git
```

Add scripts and modulefiles and source codes into the individual directory, and then enter the following command to create the container
```bash
docker build -t tings0802/hpc-base .
docker run -it tings0802/hpc-base
```

Install softwares in the container. Take GCC 8.4.0 for example: 
```bash
download_gcc 8 4 0
install_gcc 8 4 0
```

Source the scripts if the commands above are not found
```bash
source ./scripts/*.sh
```