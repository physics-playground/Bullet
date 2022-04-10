@echo off

setlocal EnableDelayedExpansion

set "_root=%~dp0"
if %_root:~-1%==\ set _root=%_root:~0,-1%
set "_root=%_root:\=/%"

:: Need to copy 32-bit and 64-bit binaries for OpenVR due to known
:: issue, see https://github.com/ValveSoftware/openvr/issues/412
if not exist "%_root%\bin" mkdir bin
if not exist "%_root%\bin\openvr_api.dll" (
    copy "%_root%\examples\ThirdPartyLibs\openvr\bin\win32\openvr_api.dll" "%~dp0bin"
)
if not exist "%_root%\bin\openvr64pi.dll" (
    copy "%_root%\examples\ThirdPartyLibs\openvr\bin\win64\openvr_api.dll" "%~dp0bin\openvr64pi.dll"
)

for /F "usebackq delims==" %%G in (`C:\Windows\System32\where.exe cmake 2^>^&1`) do (
    set _cmake=%%G
    goto:$CMakeFindDone
)
:$CMakeFindDone

set "_build_dir=%_root%/build/intermediate"
set _cmake_opts="%_cmake%" -S "%_root%"
set _premake_opts="%~dp0build\premake5.exe" --file="%~dp0build\premake5.lua"
set _vs_version=vs2022
set _vs_version_cmake=Visual Studio 17 2022

:$GetArgs
    set _build_type=%~1
    if "%~1"=="double" set _cmake_opts=!_cmake_opts! -DUSE_DOUBLE_PRECISION=ON
    if "%~1"=="double" set _premake_opts=!_premake_opts! --double

    if "%~1"=="dynamic" set _premake_opts=!_premake_opts! --dynamic-runtime
    if "%~1"=="vs2017" (
        set _vs_version=vs2017
        set _vs_version_cmake=Visual Studio 15 2017
    )
    if "%~1"=="vs2019"  (
        set _vs_version=vs2019
        set _vs_version_cmake=Visual Studio 16 2019
    )
    if "%~1"=="vs2022" (
        set _vs_version=vs2022
        set _vs_version_cmake=Visual Studio 17 2022
    )
    shift
if not "%~1"=="" goto:$GetArgs

call :FindPython

call :GetDirectoryFromPath _python_dir %PYTHON%
if %_python_dir:~-1%==\ set _python_dir=%_python_dir:~0,-1%
set "_python_dir_cmake=%_python_dir:\=/%"

echo Python: %PYTHON%
echo Python Library: %PYTHON_LIB%
echo CMake: %_cmake%

set PATH=%_python_dir%

"%_cmake%" --version > nul 2>&1
if errorlevel 1 goto:$UsePremake

::
:: CMake build
::

set "_build_dir=%_build_dir%/cmake/%_vs_version%"
set _cmake_opts=!_cmake_opts!^
 -B "%_build_dir%"^
 -DBUILD_PYBULLET=ON^
 -DCMAKE_BUILD_TYPE=Release^
 -DPYTHON_INCLUDE_DIR=%_python_dir_cmake%/include^
 -DPYTHON_LIBRARY=%_python_dir_cmake%/libs/%PYTHON_LIB%^
 -DPYTHON_DEBUG_LIBRARY=%_python_dir_cmake%/libs/%PYTHON_LIB%^
 -G "%_vs_version_cmake%"
echo ##[cmd] !_cmake_opts!
!_cmake_opts!
%_cmake% --build "%_build_dir%"
goto:$Done

::
:: Premake build
::

:$UsePremake
set "_build_dir=%_build_dir%/premake/%_vs_version%"
set _premake_opts=!_premake_opts!^
 --standalone-examples --enable_stable_pd^
 --enable_multithreading --midi ^
 --enable_static_vr_plugin --enable_openvr ^
 --enable_pybullet --python_include_dir="%_python_dir_cmake%/include"^
 --python_lib_dir="%_python_dir_cmake%/libs" --targetdir="%_build_dir%/bin" %_vs_version%
echo ##[cmd] !_premake_opts!
!_premake_opts!

call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
msbuild "%~dp0build\%_vs_version%\0_Bullet3Solution.sln" /property:Configuration=Release /p:Platform="x64"
goto:$Done

::
:: Build process complete.
::
:$Done

if errorlevel 1 (
    echo Failed to build Bullet with given settings.
) else (
    echo Successfully built Bullet!
)

exit /b

:FindPython
    setlocal EnableDelayedExpansion
        set "_out_python_path=%PYTHON%"
        if exist "!_out_python_path!" goto:$SetPython

        set _paths="C:\Python39\" "C:\Python38\" "C:\Python27\" "C:\Python26\"
        if not exist "C:\Windows\System32\where.exe" goto:$SkipPythonWhere
            for /F "usebackq delims==" %%G in (`C:\Windows\System32\where.exe python 2^>^&1`) do (
                set _paths=!_paths! "%%G"
            )
        :$SkipPythonWhere
        set _paths=!_paths! "C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python27\"
        set _paths=!_paths! "C:\Python27_64\"
        set _paths=!_paths! "C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python27_64\"
        set _paths=!_paths! "C:\Python26\"
        set _paths=!_paths! "C:\Python\"

        :: We call an 'internal' function so that we can iterate through the arguments
        :: accumulated above using 'shift' to go through each one.
        call :$$TrySetPythonExecutable "_out_python_path" !_paths!
        goto:$CheckPython

        :: Takes an output variable and a list of paths and tests each one to see if there
        :: is a valid Python executable we can use.
        :$$TrySetPythonExecutable <outputPythonPath> <inputPaths>
            setlocal EnableDelayedExpansion EnableExtensions
            set _input_path=
            set _out_var=%~1
            shift

            :$PythonCheckPathLoop
                if "%~1"=="" goto:$ReturnPythonPath
                set "_input_path=%~dp1python.exe"
                shift
                if not exist "!_input_path!" goto:$PythonCheckPathLoop
                "!_input_path!" --version > nul 2>&1
            if not "!ERRORLEVEL!"=="0" goto:$PythonCheckPathLoop

            :$ReturnPythonPath
            endlocal & (
                set "%_out_var%=%_input_path%"
            )
        exit /B
        :: $$TrySetPythonExecutable

        :$CheckPython
        if not exist "!_out_python_path!" set _out_python_path=
        :$SetPython
    endlocal & (
        set "PYTHON=%_out_python_path%"
    )

    if "%PYTHON%"=="" (
        echo [ERROR] Failed to find Python installation.
        exit /b 12
    )

    if not exist "%PYTHON%" (
        echo [ERROR] Python installation does not exist: "%PYTHON%"
        exit /b 13
    )

    for /F "usebackq delims==" %%G in (`%PYTHON% -c "import sys;print('python%%s%%s.lib'%%(sys.version_info.major, sys.version_info.minor))" 2^>^&1`) do (
        set PYTHON_LIB=%%G
    )
exit /b 0

:GetDirectoryFromPath <outputVariableName> <inputPath>
    set "%~1=%~dp2"
exit /b
