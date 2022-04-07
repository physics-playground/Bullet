@echo off

setlocal EnableDelayedExpansion

"%~dp0build\premake5.exe" --file="%~dp0build\premake5.lua" vs2022

call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
msbuild "%~dp0build\vs2022\0_Bullet3Solution.sln" /property:Configuration=Release /p:Platform="x64"
