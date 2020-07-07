# HPC-base
Dockerfiles of base images for 2020 APAC HPCAI Competition  

## Description
- `dockerfiles/`: dockerfiles of the base image  
- `scripts/`: shell scripts to install softwares  
- `modules/`: modulefiles to manage the system environment  
- `sources/`: source codes to be install  

## Usage
Clone this repository  
```bash
git clone https://github.com/tings0802/HPC-base.git
```

Add scripts and modulefiles and source codes into the corresponding directories, and then create the container  
```bash
docker build -t tings0802/hpc-base -f Dockerfile .
docker run -it tings0802/hpc-base
```

Install softwares in the container. For example:  
```bash
build_gcc 8 4 0
build_ompi 4 0 3
```

Source the scripts if the commands above are not found  
```bash
eval ${SET_SCRIPT}
# or
for file in $(ls ${SCRIPT_DIR}/*.sh); do source $file; done
```