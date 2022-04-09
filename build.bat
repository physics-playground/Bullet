@echo off

setlocal EnableDelayedExpansion

set "_root=%~dp0"
if %_root:~-1%==\ set _root=%_root:~0,-1%
set "_root=%_root:\=/%"

set "_build_dir=%_root%/build/intermediate/double_cmake"

:: aargh, see https://github.com/ValveSoftware/openvr/issues/412
if not exist "%~dp0bin" mkdir bin
if not exist "%~dp0bin\openvr_api.dll" copy "%~dp0examples\ThirdPartyLibs\openvr\bin\win32\openvr_api.dll" "%~dp0bin"
if not exist "%~dp0bin\openvr64pi.dll" copy "%~dp0examples\ThirdPartyLibs\openvr\bin\win64\openvr_api.dll" "%~dp0bin\openvr64pi.dll"

:: find a python version (hopefully just 1) and use this
dir c:\python* /b /ad > tmp1234.txt
set /p myvar1= < tmp1234.txt
set myvar=c:/%myvar1%
del tmp1234.txt

set _cmake_opts=cmake -S "%_root%" -B "%_build_dir%" -DBUILD_PYBULLET=ON

set _premake_opts="%~dp0build\premake5.exe" --file="%~dp0build\premake5.lua"

:$GetArgs
    set _build_type=%~1
    if "%~1"=="double" set _cmake_opts=!_cmake_opts! -DUSE_DOUBLE_PRECISION=ON
    if "%~1"=="double" set _premake_opts=!_premake_opts! --double
    if "%~1"=="dynamic" set _premake_opts=!_premake_opts! --dynamic-runtime
    shift
if not "%~1"=="" goto:$GetArgs

set _cmake_opts=!_cmake_opts!^
 -DCMAKE_BUILD_TYPE=Release^
 -DPYTHON_INCLUDE_DIR=c:\python38\include^
 -DPYTHON_LIBRARY=c:\python38\libs\python38.lib^
 -DPYTHON_DEBUG_LIBRARY=c:\python38\libs\python38.lib^
 -G "Visual Studio 16 2019"

set _premake_opts=!_premake_opts!^
 --standalone-examples --enable_stable_pd^
 --enable_multithreading --midi ^
 --enable_static_vr_plugin --enable_openvr ^
 --enable_pybullet --python_include_dir="%myvar%/include"^
 --python_lib_dir="%myvar%/libs" --targetdir="../bin" vs2022

cmake --version > nul 2>&1
if errorlevel 1 goto:$UsePremake

::
:: CMake build
::

echo ##[cmd] !_cmake_opts!
!_cmake_opts!
cmake --build "%_build_dir%"
goto:$Done

::
:: Premake build
::

:$UsePremake
"%~dp0build\premake5.exe" --file="%~dp0build\premake5.lua" vs2022

call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
msbuild "%~dp0build\vs2022\0_Bullet3Solution.sln" /property:Configuration=Release /p:Platform="x64"
goto:$Done

::
:: Build process complete.
::
:$Done

if errorlevel 1 (
    echo "Failed to build Bullet with given settings."
) else (
    echo "Successfully built Bullet!"
)

exit /b
