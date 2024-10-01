#!/usr/bin/env bash

set -ex

cd "${0%/*}"

# build parameters
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/11.0.0.20230328.2d22937/intrexx-11.0.0.20230328.2d22937-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/11.9.2.20240417.72d177b/intrexx-11.9.2.20240417.72d177b-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.0.0.20240528.8adb14f/intrexx-12.0.0.20240528.8adb14f-linux.tar.gz"
DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.0.1.20240918.badc4ef/intrexx-12.0.1.20240918.badc4ef-linux.tar.gz"
#DOWNLOAD_URL="https://archive.dev.intrexx.com/dev/steady/latest/setup/intrexx-latest.tar.gz"

SUITE=${1:-bookworm}
TCP_PORTS="10180 10181 10182 10183 10184 10185"

# build the image
[ -f ./build-image.sh ] || exit 1

time /bin/bash ./build-image.sh  \
  "$SUITE"                       \
  "$DOWNLOAD_URL"                \
  "$TCP_PORTS"

exit $?
