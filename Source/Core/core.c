#include <xui/core.h>
#include <sys/types.h>
#include "sysutil.h"
#include <unistd.h>
#include <stdio.h>

int xenui_is_initialized = 0;
int xenui_local_pid = 0;
FILE* xenui_local_handle = NULL;

int xui_init() {
	int pid = xenui_local_pid = getpid();
	char path[48]; sprintf(path, "/run/shm/xenui-introspect/%d/info", pid);
	rmkdir(path);
	xenui_local_handle = fopen(path, "w+");
	if (xenui_local_handle==NULL) return -1;

	xenui_is_initialized == 1;
	return 0;
}
int xui_shutdown() {
	if (xenui_is_initialized == 0) return -1;

	return xenui_is_initialized = 0;
}

