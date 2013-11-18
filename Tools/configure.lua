
if os.execute("locate libxcb.so > /dev/null") == 0 then
	print("\27[32mFound \27[36mXCB\27[0m")
	found_xcb = true
else
	print("No aviable configurations, \27[34mTERMINATING\27[0m...")
	os.exit(1)
end
