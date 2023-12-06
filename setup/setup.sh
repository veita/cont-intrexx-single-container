#!/usr/bin/env bash

set -ex

SUITE=$(lsb_release -sc)

P_OK="\033[1;32m[OK]\033[0m   "
P_ERR="\033[1;31m[ERROR]\033[0m"

IX_INSTALL_DIR="/opt/intrexx"


export DEBIAN_FRONTEND=noninteractive

apt-get update -qy
apt-get upgrade -qy

# install and configure Intrexx
if [[ ! $(ls -1 /setup/*.tar.gz 2>/dev/null | wc -l) = 1 ]]
then
  printf "$P_ERR Intrexx setup not found\n" >&2
  exit 1
fi

mkdir /setup/tmp
cd /setup/tmp

$(cat /setup/*.tar.gz | tar -xz) || exit 1

mv "/setup/tmp/$(ls)" /setup/tmp/intrexx-setup
cd /setup/tmp/intrexx-setup

# setup Intrexx
./setup.sh --console --nostart --configFile="/setup/configuration.properties"

export JAVA_HOME=/opt/intrexx/java/current
export PATH="/opt/intrexx/java/current/bin:$PATH"

# create portal
sudo -u postgres /usr/lib/postgresql/*/bin/postgres -D /etc/postgresql/*/main &> /var/log/postgresql-init.log &
PGPID=$!
/opt/intrexx/bin/linux/upixsolr start
/setup/portal/blank/setup.sh
/opt/intrexx/bin/linux/upixsolr stop
kill $PGPID

# cleanup
rm -rf /opt/intrexx/installer/setup/content
rm -rf /setup/tmp
rm -rf /tmp/* /var/tmp/*
