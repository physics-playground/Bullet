function findDirectX11()
	local dx11path = os.getenv("DXSDK_DIR")
	if (dx11path) then
		local filepath = string.format("%s%s", dx11path, "Include/D3D11.h")
		headerdx11 = io.open(filepath, "r")
		if (headerdx11) then
			printf("Found DX11: '%s'", filepath)
			return true
		end
	end
	return false
end

function initDirectX11()
	filter {}

	local dx11path = os.getenv("DXSDK_DIR")
	defines {"ADL_ENABLE_DX11"}
	includedirs {"$(DXSDK_DIR)/include"}

	filter "architecture:x86"
	libdirs {"$(DXSDK_DIR)/Lib/x86"}
	filter "architecture:x86_64"
	libdirs {"$(DXSDK_DIR)/Lib/x64"}
	filter {}
	links {"d3dcompiler", "dxerr", "dxguid", "d3dx9", "d3d9", "winmm", "comctl32", "d3dx11"}
	return true
end
