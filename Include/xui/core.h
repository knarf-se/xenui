#pragma once
/**	\brief	This function initializes XenUI
	\return	Indicates wether initialization was sucessful or not
	\retval	0	Everything is Ok
	\retval -1	Failed to aquire FS handle
	\retval -2	System/Project misconfiguration detected
*/int xui_init();

/**	\brief	Intended to clean up after XenUI
	\retval 0	Everything has been cleaned up
	\retval -1	Something was not shutdown properly
*/int xui_shutdown();

