#!/usr/bin/env bash

set -ex

cd "${0%/*}"

# build parameters
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/11.0.0.20230328.2d22937/intrexx-11.0.0.20230328.2d22937-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/11.9.2.20240417.72d177b/intrexx-11.9.2.20240417.72d177b-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/11.9.3.20250220.4bc3126/intrexx-11.9.3.20250220.4bc3126-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.0.0.20240528.8adb14f/intrexx-12.0.0.20240528.8adb14f-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.0.1.20240918.badc4ef/intrexx-12.0.1.20240918.badc4ef-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.0.2.20241204.4beaae5/intrexx-12.0.2.20241204.4beaae5-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.0.3.20250224.3292a0d/intrexx-12.0.3.20250224.3292a0d-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.0.4.20250409.549668d/intrexx-12.0.4.20250409.549668d-linux.tar.gz"
#DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.1.0.20250519.17e48e4/intrexx-12.1.0.20250519.17e48e4-linux.tar.gz"
DOWNLOAD_URL="https://download.intrexx.com/intrexx/rolling/steady/12.1.1.20250716.237b96c/intrexx-12.1.1.20250716.237b96c-linux.tar.gz"

SUITE=${1:-bookworm}
TCP_PORTS="10180 10181 10182 10183 10184 10185"

# build the image
[ -f ./build-image.sh ] || exit 1

time /bin/bash ./build-image.sh  \
  "$SUITE"                       \
  "$DOWNLOAD_URL"                \
  "$TCP_PORTS"

exit $?
