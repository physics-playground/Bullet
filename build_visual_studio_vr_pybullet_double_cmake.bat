@echo off

setlocal EnableDelayedExpansion

set "_root=%~dp0"
if %_root:~-1%==\ set _root=%_root:~0,-1%
set "_root=%_root:\=/%"

set "_build_dir=%_root%/build/intermediate/double_cmake"

cmake -S "%_root%" -B "%_build_dir%"^
    -DBUILD_PYBULLET=ON^
    -DUSE_DOUBLE_PRECISION=ON^
    -DCMAKE_BUILD_TYPE=Release^
    -DPYTHON_INCLUDE_DIR=c:\python38\include^
    -DPYTHON_LIBRARY=c:\python38\libs\python38.lib^
    -DPYTHON_DEBUG_LIBRARY=c:\python38\libs\python38.lib^
    -G "Visual Studio 16 2019"

start /D "%_build_dir%"
