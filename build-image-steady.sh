#!/usr/bin/env bash

set -ex

cd "${0%/*}"

# build parameters
DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/11.7.0.20231128.935d92e/intrexx-11.7.0.20231128.935d92e-linux.tar.gz"

SUITE=${1:-bookworm}
TCP_PORTS="10180 10181 10182 10183 10184 10185"

# build the image
[ -f ./build-image.sh ] || exit 1

time /bin/bash ./build-image.sh  \
  "$SUITE"                       \
  "$DOWNLOAD_URL"                \
  "$TCP_PORTS"

exit $?
