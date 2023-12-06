#!/bin/bash

PORTAL_CONFIG="/setup/portal/postgresql/portal.xml"

time /opt/intrexx/bin/linux/buildportal.sh -t --nostart --configFile=$PORTAL_CONFIG
