
#include "../Render.hxx"
#include <xcb/xcb.h>

/*
namespace xen {
	xcb_connection_t*	con;
	xcb_screen_t*		scr;
	Render::Render() {
		con = xcb_connect(NULL, NULL);
		scr = xcb_setup_roots_iterator(xcb_get_setup(con)).data;
	}
	Render::~Render() {
		xcb_disconnect(con);
	}
	void Render::drawRect(const Rect &re, const Style &sty) {
		xcb_rectangle_t rect[] = {
			{re.x, re.y, re.w, re.h}, NULL
		};
		xcb_poly_rectangle (con, NULL, 0, 1, rect);
	}
}
