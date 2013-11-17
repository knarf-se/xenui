#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

void print_usage() {
	puts("Usage:\n\tintrospect PID\n");
}

#pragma startup print_usage

int main(int argc, char const *argv[]) {
	if(argc<2) {
		print_usage();
		exit(1);
	}
	int pid = atoi(argv[1]);
	int is_tty, use_colors = is_tty = isatty(fileno(stdout));
	int width = 80;
	if(is_tty) {
		struct winsize ws;
		ioctl(fileno(stdout), TIOCGWINSZ, &ws);
		width = ws.ws_col;
	}
	char path[50];	//	geesh!
	sprintf(path, "/run/shm/xenui-introspect/%d/info", pid);
	struct stat stat_p;
	int r = stat(path, &stat_p);
	if(r<0) {
		switch(errno) {
			case EACCES:
				perror("Could not access introspection data");
				exit(2);
				break;
			case ENOENT:
				fprintf(stderr, "Could not find introspection data,"
					" maybe %d  is not an XenUI application or is"
					" running on a remote machine?\n", pid);
				exit(3);
		}
		perror("Oh, dear! Something unexpected happened");
		exit(37);
	}

	//	Todo: Put actual introspection code here

	return 0;
}
