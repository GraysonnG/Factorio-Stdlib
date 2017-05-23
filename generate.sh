#!/bin/bash
set -e

DIR=`pwd`
mkdir /tmp/factorio_stdlib_pages
cd /tmp/factorio_stdlib_pages
git clone https://github.com/Nexela/Factorio-Stdlib.git .
make
cd build/
cp -R doc/* "${DIR}/"
cd $DIR
rm -rf /tmp/factorio_stdlib_pages

exit 0
