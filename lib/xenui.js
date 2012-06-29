// XenUI (JS Experiment version)
// -----------------------------

// © 2012 Frank M. Eriksson

define(function(){
	var VERSION	=	'0';
	var View	=	function( file ) {
		var thiz = this;
		//this.vd = ({});
		this.loaded = false;
		console.log("Constructing new view", file, this);
		require([file],function (data) {
			console.log("View data loaded", data);
			thiz.ui = thiz.constructFrom(data);
			thiz.loaded = true;
		});
		this.render = function( ctx ) {
			if (!this.loaded)	return;
			this.ui.render(ctx);
		};
		this.constructFrom = function( data ) {
			console.log("Constructing view from data");
			if (data.type) {
				switch(data.type) {
					case 'label':
						return new Label(data.xy[0],data.xy[1],data.text);
						break;
					default:
						throw "Unknow widget!";
				}
			};
		};
		return this;
	}
	var Label	=	function( x,y,text ) {
		this.font		= '14px sans-serif';
		this.outline	= false;
		this.fill		= true;
		this.strokeStyle= 'green';
		this.fillStyle	= 'black';
		this.x = x;
		this.y = y;
		this.render = function(ctx) {
			ctx.save();
			ctx.font	= this.font;
			if( this.fill ) {
				ctx.fillStyle = this.fillStyle;
				ctx.fillText(this.text,this.x,this.y);
			}
			if( this.outline ) {
				ctx.strokeStyle = this.strokeStyle;
				ctx.strokeText(this.text,this.x,this.y);
			}
			ctx.restore();
		}
		this.setText = function(text) {
			this.text	= text;
			var ctx		= document.createElement('canvas').getContext('2d');
			ctx.font	= this.font;
			this.width	= ctx.measureText( text );
		}

		this.setText( text );
		console.log(this);
		return this;
	};
	return {
		'VERSION'	: VERSION,
		'View'		: View
	}
});
