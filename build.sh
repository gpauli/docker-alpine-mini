#!/bin/bash -e

VERSION=$(git describe --tags --abbrev=0)
ARCH=$(uname -m)
DOCKER_REPO=docker.high-con.de
V1=$(echo $VERSION | sed 's/\.\S$//')

function makeit_file() {
    file=$1
    name=$2
    echo "FROM scratch" > Dockerfile
    echo "ADD $file /" >> Dockerfile
    echo "CMD [\"/bin/sh\"]" >> Dockerfile
    docker build \
	   --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	   --build-arg VERSION=$VERSION \
	   -t makeit_alpine-mini .
    rm -f Dockerfile
    docker tag makeit_alpine-mini ${DOCKER_REPO}/${name}
    docker push ${DOCKER_REPO}/${name}
    docker image rm makeit_alpine-mini
    docker image rm ${DOCKER_REPO}/${name}
}

wget http://dl-cdn.alpinelinux.org/alpine/v${V1}/releases/${ARCH}/alpine-minirootfs-${VERSION}-${ARCH}.tar.gz
makeit_file alpine-minirootfs-${VERSION}-${ARCH}.tar.gz alpine-mini-${ARCH}:${VERSION}
rm -f alpine-minirootfs-${VERSION}-${ARCH}.tar.gz


