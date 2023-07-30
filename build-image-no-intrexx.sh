#!/usr/bin/env bash

set -ex

cd "${0%/*}"

SUITE=${1:-bookworm}
TCP_PORTS="10180 10181 10182 10183 10184 10185"

IMAGE="localhost/intrexx-single-container-no-intrexx:${SUITE}"

CONT=$(buildah from localhost/debian-systemd:-${SUITE})

buildah copy $CONT setup/ /setup

buildah run $CONT /bin/bash /setup/setup-no-intrexx.sh

for TCP_PORT in $TCP_PORTS
do
  buildah config --port "${TCP_PORT}/tcp" $CONT
done

buildah commit --rm $CONT $IMAGE

