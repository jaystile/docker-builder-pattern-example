#!/bin/bash
echo "Looking for source in /source"
# TODO: Check env. SOURCE_DIR, BUILD_DIR


# TODO: Toggle looking for source or pulling from a repository
echo "Copying source to volume to prevent permissions collisions"
mkdir -p ${BUILD_DIR}/$1

# Remove any artifacts to sync with the source folder as they get preserved with the volume
rm -rfv ${BUILD_DIR}/$1
cp -Rv ${SOURCE_DIR}/$1 ${BUILD_DIR}/$1/

cd ${BUILD_DIR}/$1
gradle clean build

