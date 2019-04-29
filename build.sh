#!/bin/bash -e


function makeit_file() {
    file=$1
    name=$2
    echo "FROM scratch" > Dockerfile
    echo "ADD $file /" >> Dockerfile
    echo "CMD [\"/bin/sh\"]" >> Dockerfile
    docker build -t $name .
    rm -f Dockerfile    
}


wget http://dl-cdn.alpinelinux.org/alpine/v3.9/releases/x86/alpine-minirootfs-3.9.3-x86.tar.gz
makeit_file alpine-minirootfs-3.9.3-x86.tar.gz alpine-mini-i386:3.9.3
rm alpine-minirootfs-3.9.3-x86.tar.gz

wget http://dl-cdn.alpinelinux.org/alpine/v3.9/releases/x86_64/alpine-minirootfs-3.9.3-x86_64.tar.gz
makeit_file alpine-minirootfs-3.9.3-x86_64.tar.gz alpine-mini-amd64:3.9.3
rm alpine-minirootfs-3.9.3-x86_64.tar.gz



