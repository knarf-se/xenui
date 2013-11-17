

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
	files { "./Source/**.*", "./Samples/dummy/**.*" }
	--[[ Doesn't work?
	if os.findlib("xcb") ~= nil then
	]]--
	if os.execute("locate libxcb.so > /dev/null") == 0 then
		print("\27[32mFound \27[36mXCB\27[0m")
		defines { "HAVE_XCB" }
		links { "xcb" }
	else
	--[[ Uncomment when SFML2 target is aviable
	if os.findlib("sfml-graphics") then
		print("Found SFML2")
		defines { "HAVE_SFML2" }
		links { "sfml-graphics" }
		files { "./Adaptor/SFML2/**.*" }
	]]--
		print("No aviable configurations, \27[34mTERMINATING\27[0m...")
		os.exit(1)
	end
