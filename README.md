[![Build](https://github.com/physics-playground/Bullet/actions/workflows/build.yml/badge.svg)](https://github.com/physics-playground/Bullet/actions/workflows/build.yml) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=physics-playground_Bullet&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=physics-playground_Bullet) [![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=physics-playground_Bullet&metric=ncloc)](https://sonarcloud.io/summary/new_code?id=physics-playground_Bullet)

# Bullet Physics SDK

This is the official C++ source code repository of the Bullet Physics SDK: real-time collision detection and multi-physics simulation for VR, games, visual effects, robotics, machine learning etc.

![PyBullet](https://pybullet.org/wordpress/wp-content/uploads/2019/03/cropped-pybullet.png)

## Issues

The Issue tracker was flooded with support questions and is closed until it is cleaned up. Use the [PyBullet forums](http://pybullet.org) to discuss with others.

## PyBullet

It is highly recommended to use PyBullet Python bindings for improved support for robotics, reinforcement learning and VR. Use pip install pybullet and checkout the [PyBullet Quickstart Guide](https://docs.google.com/document/d/10sXEhzFRSnvFcl3XxNGhnD4N2SedqwdAvK3dsihxVUA/edit#heading=h.2ye70wns7io3).

Installation is simple:

```bash
pip3 install pybullet --upgrade --user
python3 -m pybullet_envs.examples.enjoy_TF_AntBulletEnv_v0_2017may
python3 -m pybullet_envs.examples.enjoy_TF_HumanoidFlagrunHarderBulletEnv_v1_2017jul
python3 -m pybullet_envs.deep_mimic.testrl --arg_file run_humanoid3d_backflip_args.txt
```

If you use PyBullet in your research, please cite it like this:

```latex
@MISC{coumans2021,
author =   {Erwin Coumans and Yunfei Bai},
title =    {PyBullet, a Python module for physics simulation for games, robotics and machine learning},
howpublished = {\url{http://pybullet.org}},
year = {2016--2021}
}
```

## Requirements for Bullet Physics C++

A C++ compiler for C++ 2003. The library is tested on Windows, Linux, Mac OSX, iOS, Android,
but should likely work on any platform with C++ compiler.
Some optional demos require OpenGL 2 or OpenGL 3, there are some non-graphical demos and unit tests too.

## Contributors and Coding Style information

[CodingStyle - Google Docs](https://docs.google.com/document/d/1u9vyzPtrVoVhYqQOGNWUgjRbfwfCdIts_NzmvgiJ144/edit)

## Requirements for experimental OpenCL GPGPU support

The entire collision detection and rigid body dynamics can be executed on the GPU.

* A high-end desktop GPU, such as an AMD Radeon 7970 or NVIDIA GTX 680 or better.
* We successfully tested the software under Windows, Linux and Mac OSX.
* The software currently doesn't work on OpenCL CPU devices. It might run on a laptop GPU but performance will not likely be very good. Note that often an OpenCL drivers fails to compile a kernel. Some unit tests exist to track down the issue, but more work is required to cover all OpenCL kernels.

## License

All source code files are licensed under the permissive zlib license
[permissive zlib license](https://opensource.org/licenses/Zlib) unless marked differently in a particular folder/file.

## Build instructions for Bullet using vcpkg

You can download and install Bullet using the [vcpkg](https://github.com/Microsoft/vcpkg/) dependency manager:

```bash
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install
./vcpkg install bullet3
```

The Bullet port in vcpkg is kept up to date by Microsoft team members and community contributors. If the version is out of date, please [create an issue or pull request](https://github.com/Microsoft/vcpkg) on the vcpkg repository.

## Build instructions for Bullet using premake. You can also use cmake instead.

### Windows

Click on `build_visual_studio_vr_pybullet_double.bat` and open `build/vs2019/0_Bullet3Solution.sln`
When asked, convert the projects to a newer version of Visual Studio.

If you installed Python in the `C:\` root directory, the batch file should find it automatically.
Otherwise, edit this batch file to choose where Python include/lib directories are located.

### Windows Virtual Reality sandbox for HTC Vive and Oculus Rift

Build and run the App_SharedMemoryPhysics_VR project, preferably in Release/optimized build.
You can connect from Python pybullet to the sandbox using:

```python
import pybullet as p

# or (p.TCP, "localhost", 6667) or (p.UDP, "192.168.86.10",1234)
p.connect(p.SHARED_MEMORY)
```

### Linux and Mac OSX gnu make

Make sure `cmake` is installed using  `sudo apt-get install cmake`, `brew install cmake`, or from [CMake](https://cmake.org/).

In a terminal type:

```bash
./build_cmake_pybullet_double.sh
```

This script will invoke cmake and build in the build_cmake directory. You can find pybullet in Bullet/examples/pybullet.
The BulletExampleBrowser binary will be in Bullet/examples/ExampleBrowser.

You can also build Bullet using [Premake](https://premake.github.io/). There are `premake` executables in the `build` folder.

Depending on your system (Linux 32bit, 64bit or Mac OSX) use one of the following lines:

```bash
cd build
./premake4_linux --double gmake
./premake4_linux64 --double gmake
./premake4_osx --double --enable_pybullet gmake
```

Then

```bash
cd gmake
make
```

Note that on Linux, you need to use cmake to build `pybullet`, since the compiler has issues of mixing shared and static libraries.

### Mac OSX Xcode

Click on `build.command` or in a terminal window execute

```bash
./premake_osx xcode4
```

## Usage

The `App_ExampleBrowser` executables will be located in the `bin` folder. You can run it though a terminal/command prompt, or by clicking it.

```ini
[--start_demo_name="Demo Name"]     Start with a selected demo
[--mp4=moviename.mp4]               Create a mp4 movie of the window, requires ffmpeg installed
[--mouse_move_multiplier=0.400000]  Set the mouse move sensitivity
[--mouse_wheel_multiplier=0.01]     Set the mouse wheel sensitivity
[--background_color_red= 0.9]       Set the red component for background color. Same for green and blue
[--fixed_timestep= 0.0]             Use either a real-time delta time (0.0) or a fixed step size (0.016666)
```

You can use mouse picking to grab objects. When holding the `ALT` or `CONTROL` key, you have Maya style camera mouse controls.

Press `F1` to create a series of screenshots. Hit `ESCAPE` to exit the demo app.

Check out the docs folder and the Bullet physics forums for further information.
