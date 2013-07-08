#pragma once
#include <XenUI/Container.hxx>

namespace xen {
	class Window : public Container {
	public:
		Window();
		~Window();

	private:
		Rect bounds;
	};
}
