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

Finally, source the scripts to install software in the container
```bash
source ./scripts/<script.sh>
```