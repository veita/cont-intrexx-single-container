#!/usr/bin/env bash

set -ex

SUITE=$(lsb_release -sc)

export DEBIAN_FRONTEND=noninteractive

apt-get update -qy
apt-get upgrade -qy

# install Git and ImageMagick
apt-get install -qy git mc imagemagick

# Postfix is needed to prevent excessive package pulls (Exim etc.) later
debconf-set-selections <<< "postfix postfix/mailname string 'localhost'"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Local only'"
apt-get install -qy postfix

# install and configure PostgreSQL
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ $SUITE-pgdg main" >> /etc/apt/sources.list

apt-get update -qy
apt-get install -qy postgresql

sed -i 's/^port.*$/port = 5432/g' /etc/postgresql/*/main/postgresql.conf
sed -i -r 's/(.*127\.0\.0\.1\/32\s+)md5$/\1trust/g' /etc/postgresql/*/main/pg_hba.conf
sed -i -r 's/(.*::1\/128\s+)md5$/\1trust/g' /etc/postgresql/*/main/pg_hba.conf
sed -i -r 's/(.*127\.0\.0\.1\/32\s+)scram-sha-256$/\1trust/g' /etc/postgresql/*/main/pg_hba.conf
sed -i -r 's/(.*::1\/128\s+)scram-sha-256$/\1trust/g' /etc/postgresql/*/main/pg_hba.conf

$(shopt -s dotglob ; cp /etc/skel/* /var/lib/postgresql/)

# services
systemctl enable postfix
systemctl enable postgresql

# cleanup
apt-get clean -qy
apt-get autoremove -qy

# modify .bashrc for root
cat << EOF >> /root/.bashrc

alias p='cd /opt/intrexx/org/*/'
alias pl='less /opt/intrexx/org/*/log/portal.log'
EOF

# add Intrexx user
useradd -m -s /bin/bash --uid 1000 intrexx

# cleanup
rm -rf /tmp/* /var/tmp/*
