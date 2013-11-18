#include <stdio.h>
#include <xui/core.h>

int main(int argc, char const *argv[]) {
	printf("Hello, There!\n\nYou should really help out if you can! ;-)\n");
	if(xui_init())fprintf(stderr, "[\x1b[31mERR!\x1b[0m]:"
		"  \x1b[33mFailed to initialize XenUI\x1b[0m!\n");
	return 0;
}
