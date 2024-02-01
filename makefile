
ROOT = ${abspath .}
RUNTIME = ${ROOT}/runtime
IMAGES = ${ROOT}/images

SRC = ${ROOT}/src

INSTANCE = ${abspath ${RUNTIME}/resume}
VOLUMES = ${abspath ${RUNTIME}/volumes}

LATEX_IMAGE_DIR = ${IMAGES}/latex

export PATH := ${abspath ${ROOT}/bin/}:${PATH}

default: images instance

images: latex_image

latex_image: ${LATEX_IMAGE_DIR}/Dockerfile 
	docker build --tag mm/latex ${LATEX_IMAGE_DIR}

instance: entry workspace_link composition 

entry:
	mkdir -p ${INSTANCE}
	cp -rvf ${SRC}/* ${INSTANCE}

workspace_link:  
	ln -sfn ${INSTANCE} ${RUNTIME}/workspace_volume

composition:
	cp -rvf resume.yml ${RUNTIME}

#clean will remove running containers and server config
#sterile will clean, then remove ALL volumes and ALL images- even unrelated ones

clean:
	exec docker-clean

cleaner: clean
	rm -rf ${VOLUMES}/*

sterile: cleaner
	exec docker-rmi

