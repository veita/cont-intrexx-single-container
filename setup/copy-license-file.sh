#!/bin/sh

set -ex

cd /opt/intrexx/org/* || exit 0

if [[ -f /run/secrets/license*.cfg && ! grep -q 'license key=' internal/cfg/license.cfg ]]
then
  printf "Copy license file\n"
  cp /run/secrets/license*.cfg internal/cfg/license.cfg
  chown --reference=/opt/intrexx internal/cfg/license.cfg
fi

