#pragma once

typedef struct xui_widget;

void xui_draw_widget(xcb_connection_t *c, xcb_screen_t *s, xcb_window_t w, xui_widget a);