
	project "hello_gtest"

	kind "ConsoleApp"

--	defines {  }

	targetdir "../../bin"

	includedirs
	{
		".","../gtest-1.7.0/include"
	}

	if os.istarget("Windows") then
		--see http://stackoverflow.com/questions/12558327/google-test-in-visual-studio-2012
		defines {"_VARIADIC_MAX=10"}
	end

--        linkLib "gtest"
	links "gtest"


	files {
		"**.cpp",
		"**.h",
	--	"../gtest-1.7.0/src/gtest_main.cc"
	}
	if os.istarget("Windows") then
	end

	if os.istarget("Linux") then
	end

	if os.istarget("MacOSX") then
	end
