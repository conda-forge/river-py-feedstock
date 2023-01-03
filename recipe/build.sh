#!/bin/bash

set -x -e
set -o pipefail

cd python

mkdir -p build/release
cd build/release

if [[ "${target_platform}" != osx-arm64 ]]; then
  cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DRIVER_INSTALL=ON \
    -DPython3_EXECUTABLE="${PYTHON}" \
    ${CMAKE_ARGS} \
    ../..
else
  PYTHON3_EXECUTABLE_PATH=`which python`
  cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DRIVER_INSTALL=ON \
    -DPython3_EXECUTABLE=${PYTHON3_EXECUTABLE_PATH} \
    ${CMAKE_ARGS} \
    ../..
fi

make
make install

