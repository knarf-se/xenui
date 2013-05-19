#pragma once
#include <XenUI/Event.hxx>
#include <XenUI/Rect.hxx>


namespace xen {
	typedef enum {
		Resting,
		Focused,
		Disabled
	} State;

	class Base {
	public:
		virtual ~Base();
		int recieve(const Event &ev);
		virtual void draw() = 0;

		State currently;

	protected:
		Base();
		Rect bounds;
	};
}
