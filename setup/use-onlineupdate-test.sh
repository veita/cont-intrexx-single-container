#!/bin/sh

CFG="/opt/intrexx/cfg/downloadmanager.yml"

[ -f "$CFG"  ] && sed -i 's|/onlineupdate.|/onlineupdate-test.|g' "$CFG"

