
--[[
lust.check('Xephyr', 'xserver-xephyr')
]]

os.execute('Xephyr :1337 &'
	..'xephyrid=$!;'
	..'DISPLAY=1337 ./rx-test;'
	..'kill -9 $xephyrid')
