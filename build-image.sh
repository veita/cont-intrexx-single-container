#!/usr/bin/env bash

set -ex

cd "${0%/*}"

# this script requires four parameters
if [ "$#" -ne 3 ]
then
    printf "Illegal number of arguments\n" >&2
    exit 1
fi

SUITE="$1"
DOWNLOAD_URL="$2"
TCP_PORTS="$3"

IX_ARCHIVE_NAME="$(basename $DOWNLOAD_URL)"
TAG="${IX_ARCHIVE_NAME%%.???????-linux.tar.gz}"

if [ ! -f "work/$IX_ARCHIVE_NAME" ]
then
  (cd work/ ; curl -O "$DOWNLOAD_URL" || exit 1)
fi

IMAGE="localhost/intrexx-single-container:${TAG}"

CONT=$(buildah from localhost/intrexx-single-container-no-intrexx:${SUITE})

buildah copy $CONT setup/ /setup

buildah copy $CONT "work/$IX_ARCHIVE_NAME" "/setup/$IX_ARCHIVE_NAME"
buildah run $CONT /bin/bash /setup/setup.sh
buildah run $CONT rm "/setup/$IX_ARCHIVE_NAME"

for TCP_PORT in $TCP_PORTS
do
  buildah config --port "${TCP_PORT}/tcp" $CONT
done

buildah commit --rm $CONT $IMAGE
