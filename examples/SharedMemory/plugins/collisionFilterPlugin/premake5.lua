

project ("pybullet_collisionFilterPlugin")
		language "C++"
		kind "SharedLib"

		includedirs {".","../../../../src", "../../../../examples",
		"../../../ThirdPartyLibs"}
		defines {"PHYSICS_IN_PROCESS_EXAMPLE_BROWSER"}
	hasCL = findOpenCL("clew")

	links{"BulletFileLoader", "Bullet3Common", "LinearMath"}


	if os.istarget("MacOSX") then
--		targetextension {"so"}
		links{"Cocoa.framework","Python"}
	end


		files {
			"collisionFilterPlugin.cpp",
			"../../PhysicsClient.cpp",
			"../../PhysicsClient.h",
			"../../PhysicsClientSharedMemory.cpp",
			"../../PhysicsClientSharedMemory.h",
			"../../PhysicsClientSharedMemory_C_API.cpp",
			"../../PhysicsClientSharedMemory_C_API.h",
			"../../PhysicsClientC_API.cpp",
			"../../PhysicsClientC_API.h",
			"../../Win32SharedMemory.cpp",
			"../../Win32SharedMemory.h",
			"../../PosixSharedMemory.cpp",
			"../../PosixSharedMemory.h",
			"../../../Utils/b3Clock.cpp",
			"../../../Utils/b3Clock.h",
			"../../../Utils/b3ResourcePath.cpp",
			"../../../Utils/b3ResourcePath.h",
				}



