#!/usr/bin/env bash
set -ex

_bullet_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && cd ../ && pwd)

echo "CXX=${CXX:-}"
echo "CC=${CC:-}"

$SUDO apt-get update
$SUDO apt-get install -y python3
$SUDO apt-get install -y python3-pip
$SUDO apt-get install python3-dev
$SUDO pip3 install -U wheel
$SUDO pip3 install -U setuptools
python3 "$_bullet_root/setup.py" install --user
python3 "$_bullet_root/examples/pybullet/unittests/unittests.py" --verbose
python3 "$_bullet_root/examples/pybullet/unittests/userDataTest.py" --verbose
python3 "$_bullet_root/examples/pybullet/unittests/saveRestoreStateTest.py" --verbose

_build="$_bullet_root/build/intermediate/make_pybullet"
cmake -B "$_build" -S . -DBUILD_PYBULLET=ON -G"Unix Makefiles"
make -c "$_build" -j8
ctest -B "$_build" -j8 --output-on-failure

# Build again with double precision
_build="$_bullet_root/build/intermediate/make_double"
cmake -B "$_build" -S . -DUSE_DOUBLE_PRECISION=ON -G "Unix Makefiles"
make -c "$_build" -j8
ctest -B "$_build" -j8 --output-on-failure

# Build again with shared libraries
_build="$_bullet_root/build/intermediate/make_shared"
cmake -B "$_build" -S . -DBUILD_SHARED_LIBS=ON -G "Unix Makefiles"
make -c "$_build" -j8
ctest -B "$_build" -j8 --output-on-failure
$SUDO make install
