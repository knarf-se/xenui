#pragma once

typedef struct XUI_DRAWABLE *xui_drawable;
typedef struct XUI_STYLE *xui_style;

xui_line(xui_drawable d, xui_style s,
			int x0,int y0,
			int x1,int y1
		);

