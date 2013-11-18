#pragma once

typedef struct {
/*
	enum {FLOAT, INT} type;
	union{ float rf; int r; };
	union{ float gf; int g; };
	union{ float bf; int b; };
	union{ float af; int a; };
*/
	unsigned int r, g, b, a;
} xui_colour;

static inline xui_colour xui_colour_mix(xui_colour a, xui_colour b, float f) {
	float invf=(1.0f-f);
	xui_colour c;
	x.r = a.r*f+b.r*invf;
	x.r = a.g*f+b.g*invf;
	x.r = a.b*f+b.b*invf;
	x.r = a.a*f+b.a*invf;
}

