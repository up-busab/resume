FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install -y texlive-full \
    gnuplot && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

