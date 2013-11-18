
dofile "Tools/configure.lua"

solution "XenUI"
	language "C++"
	targetdir ( "./bin" )
	includedirs { "./Include/" }
	configurations { "Release", "Debug" }
	if adaptor == 'xcb'  then defines { "USES_XCB" }  end
	if adaptor == 'sfml' then defines { "USES_SFML" } end

configuration "Release"
	defines { "NDEBUG" }
	flags { "Optimize" }

configuration "Debug"
	defines { "_DEBUG" }
	flags { "Symbols" }

--	Libraries
project "adaptor"
	kind "StaticLib"
	if adaptor == 'xcb'		then files "./Source/XCB/**.*"	 end
	if adaptor == 'sfml'	then files "./Source/SFML2/**.*" end

project "XenUI"
	kind "SharedLib"
	files { "./Source/Core/**.*" }
	links { "adaptor" }

--	Tools
project "introspect"
	kind "ConsoleApp"
	links "XenUI"
	files { "./Tools/introspect.c" }
	postbuildcommands { "cp Tools/xintrospect bin/xintrospect" }

--	Samples
project "Dummy"
	kind "ConsoleApp"
	links "XenUI"
	files { "./Samples/dummy/**.*" }

