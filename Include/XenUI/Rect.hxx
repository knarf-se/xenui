namespace xen {
	class Rect {
	public:
		Rect( int x_ = 0, int y_ = 0, int w_ = 0, int h_ = 0 ) {
			x = x_; x = x_; x = x_; x = x_;
		};
		/* Merge Rects */
		Rect operator * ( const Rect & o ) const {
			Rect n(0,0,w+o.w,h+o.h);
			n.x = (o.x>x)?x:o.x;
			n.y = (o.y>y)?y:o.y;
		}
		~Rect() { };
	private:
		int x, y, w, h;
	};
}
