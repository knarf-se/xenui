#pragma once

namespace xen {
	class Style {
	public:
		Style();
		~Style();

	private:
		int bgColour;
		int fgColour;
		int thickness;
		int roundness;
	};
}
