#!/bin/bash

# before running this script, run `docker login`
set -eux
OACIS_VERSION="v3.4.0"

docker login
SCRIPT_DIR=$(cd $(dirname $0);pwd)
cd $SCRIPT_DIR/oacis
docker build . -t oacis/oacis:${OACIS_VERSION} --build-arg OACIS_VERSION=${OACIS_VERSION}
docker push oacis/oacis:${OACIS_VERSION}

cd $SCRIPT_DIR/oacis_jupyter
docker build . -t oacis/oacis_jupyter:${OACIS_VERSION} --build-arg OACIS_VERSION=${OACIS_VERSION}
docker push oacis/oacis_jupyter:${OACIS_VERSION}

git tag -a ${OACIS_VERSION} -m "version ${OACIS_VERSION}"
git push --tags