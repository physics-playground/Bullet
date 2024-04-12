	project "lua-5.2.3"

	kind "StaticLib"

	--flags {}


	defines { "LUA_COMPAT_ALL"}

	if os.istarget("Linux") then
		defines {"LUA_USE_LINUX"}
	end
	if os.istarget("MacOSX") then
		defines {"LUA_USE_MACOSX"}
	end

	targetdir "../../../lib"
	includedirs {
		"src"
	}
    if os.istarget("Linux") then
        buildoptions{"-fPIC"}
    end
	files {
		"src/*.c",
		"src/*.h"
	}

include "lua_compiler"
include "lua_standalone"