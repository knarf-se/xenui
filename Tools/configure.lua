

--	List of aviable adaptors
local adaptors = {
	sfml	=	'sfml-graphics',
	xcb		=	'xcb',
}--	Last one will be the default

--	check for library and print xmas-tree ;-)
function findlib(name)
	io.write("\27[33mChecking for \27[36m"..name.."\27[0m .. ")
	if os.execute("locate lib"..name..".so > /dev/null") == 0 then
		print("\27[32mFound\27[0m")
		return true
	else
		print("\27[31mMissing\27[0m")
		return false
	end
end

--	Choose what “adaptor” to use (Windowing backend)
adaptor = "none"
for lib in pairs(adaptors) do
	local found = findlib(lib)
	if found then adaptor = lib end
end

if adaptor == "none" then
	print("No aviable configurations, \27[34mTERMINATING\27[0m...")
	os.exit(1)
else
	print("\27[32mUsing \27[36m"..adaptor.."\27[0m")
end

--	Moar stuff

