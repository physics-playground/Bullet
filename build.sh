#!/bin/sh

if [ -n "${ZSH_VERSION:-}" ]; then
    # shellcheck disable=SC3057
    _root="${0:a:h}"
elif [ -n "${BASH:-}" ]; then
    # shellcheck disable=SC3028,SC3054
    _root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    _root="."
fi

_build_dir="$_root/build/intermediate/cmake"

if [ -e "$_root/CMakeCache.txt" ]; then
    rm "$_root/CMakeCache.txt"
fi

if ! cmake \
    -S "$_root" -B "$_build_dir" \
    -DBUILD_PYBULLET=ON -DBUILD_PYBULLET_NUMPY=ON \
    -DUSE_DOUBLE_PRECISION=ON -DBT_USE_EGL=ON \
    -DCMAKE_BUILD_TYPE=Release "$_root"; then
    exit 1
fi

if ! make -C "$_build_dir" -j "$(command nproc 2>/dev/null || echo 12)"; then
    exit 2
fi

cd "$_build_dir/examples/pybullet" || true

if [ -e "$_build_dir/examples/pybullet/pybullet.dylib" ]; then
    ln -f -s \
        "$_build_dir/examples/pybullet/pybullet.dylib" \
        "$_build_dir/examples/pybullet/pybullet.so"
fi

if [ -e $_build_dir/examples/pybullet/pybullet_envs ]; then
    rm "$_build_dir/examples/pybullet/pybullet_envs"
fi

if [ -e $_build_dir/examples/pybullet/pybullet_data ]; then
    rm "$_build_dir/examples/pybullet/pybullet_data"
fi

if [ -e $_build_dir/examples/pybullet/pybullet_utils ]; then
    rm "$_build_dir/examples/pybullet/pybullet_utils"
fi

ln -s "$_root/examples/pybullet/gym/pybullet_envs" .
ln -s "$_root/examples/pybullet/gym/pybullet_data" .
ln -s "$_root/examples/pybullet/gym/pybullet_utils" .

echo "Completed build of Bullet."
