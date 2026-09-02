#!/usr/bin/env bash

set -exuo pipefail

cd "${0%/*}"


# build parameters
DOWNLOAD_URL="https://update.intrexx.com/intrexx/12.2.0.20260623.f60193c/server/intrexx-setup-linux-amd64.tar.gz"

SUITE=${1:-trixie}
TCP_PORTS="10180 10181 10182 10183 10184 10185"


IX_ARCHIVE_NAME="$(basename $DOWNLOAD_URL)"
TAG="${DOWNLOAD_URL#*\/intrexx/}"
TAG="${TAG%%/server/*}"

if [ ! -f "work/$TAG/$IX_ARCHIVE_NAME" ]
then
  (mkdir -p "work/$TAG" && cd "work/$TAG" && curl -fnsSL -O "$DOWNLOAD_URL" || exit 1)
fi

IMAGE="localhost/intrexx-single-container:${TAG}"

CONT=$(buildah from localhost/intrexx-single-container-no-intrexx:${SUITE})

buildah copy $CONT setup/ /setup

buildah copy $CONT "work/$TAG/$IX_ARCHIVE_NAME" "/setup/$IX_ARCHIVE_NAME"
buildah run $CONT /bin/bash /setup/setup.sh
buildah run $CONT rm "/setup/$IX_ARCHIVE_NAME"

for TCP_PORT in $TCP_PORTS
do
  buildah config --port "${TCP_PORT}/tcp" $CONT
done

buildah commit --rm $CONT $IMAGE
