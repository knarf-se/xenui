#pragma once
#include <xui/Event.hxx>
#include <xui/Rect.hxx>

namespace xen {
	class Thingie {
	public:
		virtual ~Thingie();
		virtual int recieve(const Event &ev) = 0;
		virtual void draw() = 0;

	protected:
		Thingie();
		Rect bounds;
	};
}
