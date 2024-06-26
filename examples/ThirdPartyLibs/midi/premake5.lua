
	project "rtMidiTest"

	kind "ConsoleApp"

--	defines {  }


	includedirs
	{
		".",
	}


--	links { }


	files {
		"**.cpp",
		"**.h"
	}
	if os.istarget("Windows") then
		links {"winmm"}
		defines {"__WINDOWS_MM__", "WIN32"}
	end

	if os.istarget("Linux") then
		defines {"__LINUX_ALSA__"}
                links {"asound","pthread"}
	end

	if os.istarget("MacOSX") then
		links{"CoreAudio.framework", "coreMIDI.framework", "Cocoa.framework"}
		defines {"__MACOSX_CORE__"}
	end
