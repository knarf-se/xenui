

solution "XenUI"
	language "C++"
	kind "ConsoleApp"
	targetdir ( "./bin" )
	includedirs { "./Include/" }

	configurations { "Release", "Debug" }

configuration "Release"
	defines { "NDEBUG" }
	flags { "Optimize" }

configuration "Debug"
	defines { "_DEBUG" }
	flags { "Symbols" }

project "XenUI"
	files { "./Source/**.*", "./Example/**.*" }
