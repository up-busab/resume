#!/bin/bash
HERE=$(pwd)

export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain

notify()
{
    echo -e "\033[1;91m$1\033[0m"
}

notify "Building LaTeX containter"
docker build --network host --tag mm/latex -f $HERE/src/Dockerfile_texlive .

notify "Populating runtime"
mkdir -p $HERE/runtime/instance
cp -v $HERE/src/resume.yml $HERE/runtime
cp -rv $HERE/src/tex/* $HERE/runtime/instance

notify "Rendering document"
CURRENT_UID=$(id -u):$(id -g) docker compose -f $HERE/runtime/resume.yml up

notify "Copy document"
cp runtime/instance/current_resume.pdf .

notify "clean up"
rm -rf $HERE/runtime
