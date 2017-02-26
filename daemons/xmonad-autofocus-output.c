/* -lX11 -lXtst */

#include <sys/select.h>
#include <errno.h>
#include <stdio.h>

#define XK_MISCELLANY
#define XK_LATIN1
#include <X11/Xlib.h>
#include <X11/keysymdef.h>
#include <X11/extensions/XTest.h>

static Display *disp;
static KeyCode mod, key[2];

static inline int
get_output(int x, int y)
{
	return x < 1600;
}

static inline void
set_output(int output)
{
	XTestFakeKeyEvent(disp, mod, 1, 0);
	XTestFakeKeyEvent(disp, key[output], 1, 0);
	XTestFakeKeyEvent(disp, key[output], 0, 0);
	XTestFakeKeyEvent(disp, mod, 0, 0);
	XFlush(disp);
}

int
main(int argc, char *argv[])
{
	int fd, scrn;
	Window root;
	fd_set fds;
	XEvent ev;
	int output, prev_output = -1;

	XSetLocaleModifiers("");
	if (!(disp = XOpenDisplay(NULL))) {
		fprintf(stderr, "%s: cannot open display\n", *argv);
		return 1;
	}

	fd = XConnectionNumber(disp);
	scrn = XDefaultScreen(disp);
	root = XRootWindow(disp, scrn);
	XSelectInput(disp, root, PointerMotionMask | EnterWindowMask);
	XSync(disp, False);

	mod = XKeysymToKeycode(disp, XK_Super_L);
	key[0] = XKeysymToKeycode(disp, XK_W);
	key[1] = XKeysymToKeycode(disp, XK_E);

	for (;;) {
		FD_ZERO(&fds);
		FD_SET(fd, &fds);

		if (select(fd + 1, &fds, NULL, NULL, NULL) < 0) {
			if (errno == EINTR)
				continue;
			perror(*argv);
			return 1;
		}

		if (!FD_ISSET(fd, &fds))
			continue;

		while (XPending(disp)) {
			XNextEvent(disp, &ev);
			if (XFilterEvent(&ev, None))
				continue;
			switch (ev.type) {
			case MotionNotify:
				output = get_output(ev.xmotion.x_root, ev.xmotion.y_root);
				if (output == prev_output)
					continue;
				prev_output = output;
				set_output(output);
				break;
			case EnterNotify:
				prev_output = -1;
				break;
			default:
				break;
			}
		}
	}

	return 0;
	(void) argc;
}
