#include <string.h>
#include <fcntl.h>

int rmkdir(const char *path) {
	char opath[256];
	char *p;
	size_t len;
	int ret;

	strncpy(opath, path, sizeof(opath));
	len = strlen(opath);
	if(opath[len - 1] == '/')
		opath[len - 1] = '\0';
	for(p = opath; *p; p++)
		if(*p == '/') {
			*p = '\0';
			if(access(opath, F_OK))
				ret = mkdir(opath, S_IRWXU);
			*p = '/';
		}
	return ret;
}
