// XenUI (JS Experiment version)
// -----------------------------

// © 2012 Frank M. Eriksson

define({
	VERSION	:	'0',
	View	:	function( file ) {
		var thiz = this;
		//this.vd = ({});
		this.loaded = false;
		console.log("Constructing new view", file, this);
		require([file],function (data) {
			console.log("View data loaded", data);
			thiz.constructFrom(data);
			thiz.loaded = true;
		});
		this.render = function( ctx ) {
			if (!this.loaded) return;
		};
		this.constructFrom = function( data ) {
			console.log("Constructing view from data");
		};
		return this;
	}
});
