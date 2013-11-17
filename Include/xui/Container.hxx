#pragma once
#include <xui/Thingie.hxx>

namespace xen {
	class Container : public Thingie {
	public:
		Container();
		~Container();
		int send(const Event &ev);
	};
}
