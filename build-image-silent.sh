#!/usr/bin/env bash

set -ex

cd "${0%/*}"

# build parameters
DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/silent/11.0.7.20231128.d10097d/intrexx-11.0.7.20231128.d10097d-linux.tar.gz"

SUITE=${1:-bookworm}
TCP_PORTS="10180 10181 10182 10183 10184 10185"

# build the image
[ -f ./build-image.sh ] || exit 1

time /bin/bash ./build-image.sh  \
  "$SUITE"                       \
  "$DOWNLOAD_URL"                \
  "$TCP_PORTS"

exit $?
