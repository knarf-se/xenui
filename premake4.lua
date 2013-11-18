
dofile "Tools/configure.lua"

solution "XenUI"
	language "C++"
	targetdir ( "./bin" )
	includedirs { "./Include/" }

	configurations { "Release", "Debug" }
	if found_xcb == true then
		print("\27[32mUsing \27[36mXCB\27[0m")
		defines { "USES_XCB" }
	end

configuration "Release"
	defines { "NDEBUG" }
	flags { "Optimize" }

configuration "Debug"
	defines { "_DEBUG" }
	flags { "Symbols" }

project "XenUI"
	 kind "SharedLib"
	files { "./Source/Core/**.*" }
	--[[ Doesn't work?
	if os.findlib("xcb") ~= nil then
	]]--
	if found_xcb then
		links { "xcb" }
		files { "./Source/XCB/**.*" }
	end
	--[[ Uncomment when SFML2 target is aviable
	if os.findlib("sfml-graphics") then
		print("Found SFML2")
		defines { "HAVE_SFML2" }
		links { "sfml-graphics" }
		files { "./Adaptor/SFML2/**.*" }
	]]--

project "Dummy"
	kind "ConsoleApp"
	links "XenUI"
	files { "./Samples/dummy/**.*" }

