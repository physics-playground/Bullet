	project "HACD"

	kind "StaticLib"

	includedirs {"."}
    if os.istarget("Linux") then
        buildoptions{"-fPIC"}
    end
	files {
		"**.cpp",
		"**.h"
	}
