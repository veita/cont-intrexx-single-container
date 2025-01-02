#!/bin/bash

SRC=/opt/intrexx
DST=./build/intrexx-manager

mkdir -p "$DST"

# version files
VERFILE=$(cd "$SRC" ; ls *.version | sort -g | tail -n1)
cp -p "$SRC/$VERFILE" "$DST"
echo -n ${VERFILE%.version} > "$DST/version"

# cfg
mkdir -p "$DST/cfg"
cp -p "$SRC/cfg/downloadmanager.yml" "$DST/cfg/downloadmanager.yml"

cat << EOF > "$DST/cfg/downloadmanager.yml"
---
sourceUrl: https://onlineupdate.intrexx.com/intrexx/rolling/
destinationDirectory: installer/update
artifact: MANAGER
EOF

# client
cp -pr "$SRC/client" "$DST"
rm -f "$DST/client/bin/linux/ixmanager.desktop"
rm -f "$DST/client/cfg/oldclient.cfg"

# fonts
cp -pr "$SRC/fonts" "$DST"

# installer
mkdir -p "$DST/installer"
cp -p "$SRC/installer/license.html" "$DST/installer/license.html"
cp -p "$SRC/installer/license.txt" "$DST/installer/license.txt"
cp -p "$SRC/installer/license_de.html" "$DST/installer/license_de.html"
cp -p "$SRC/installer/license_de.txt" "$DST/installer/license_de.txt"

# Java
mkdir -p "$DST/java"
JDK_SRC=`find /opt/intrexx/java/packaged -type f -name release -exec dirname {} \;`
cp -pr "$JDK_SRC" "$DST/java/current"

# JavaFX
cp -pr "$SRC/jfx" "$DST"

# res
cp -pr "$SRC/res" "$DST"
