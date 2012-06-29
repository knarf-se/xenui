// XenUI (JS) Test
// ---------------

console.log('XenUI (JS) Test');

/*requirejs.config({
	paths:	{	'zepto':
		'http://cdnjs.cloudflare.com/ajax/libs/zepto/1.0rc1/zepto.min'	}
});*/

var rAF = window.rAF = (function(callback) {
	return  window.requestAnimationFrame	||
		window.webkitRequestAnimationFrame	||
		window.mozRequestAnimationFrame		||
		window.oRequestAnimationFrame		||
		function(callback) {
			window.setTimeout(callback, 1000 / 60);
		};
})();

require([/*'zepto',*/'lib/xenui'], function init(/*Zep,*/xenui) {
	console.log(xenui.VERSION);
//	var root = this;
	
	// Way overkill
//	var $ = root.Zepto || root.jQuery || root.ender;
//	var can = $("#can")[0];
	var can = document.getElementById("can");
	var ctx = can.getContext("2d");
	
	ctx.background = 'black';
	ctx.fillRect(0,0,500,500);
	
	console.log();
	var view = new xenui.View('view/main');
	
	console.log('Setting up renderloop.');
	rAF(function render(Δ) {
		/// Note:	Should only render /if/ there is a need to render!
		/// FixME:	I am lazy as heck ;-)
		ctx.clearRect(0,0,500,500);
		view.render(ctx);
		rAF(render);
		});
	
	/// TODO: Code up Event to Signal-translator..
	
	console.log('EOM');
});
