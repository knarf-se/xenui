#pragma once
#include <xui/Container.hxx>

namespace xen {
	class Window : public Container {
	public:
		Window();
		~Window();

	private:
		Rect bounds;
	};
}
