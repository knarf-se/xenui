
#include <XenUI/Rect.hxx>
#include <XenUI/Style.hxx>

namespace xen {
	class Render {
	public:
		Render();
		~Render();
	
		void drawRect(const Rect &re, const Style &sty);
		/* etc.. */
	};
}
