# XenUI (JS) Test
# ---------------
console.log('XenUI (JS) Test');

requirejs.config paths:
	zepto: "http://cdnjs.cloudflare.com/ajax/libs/zepto/1.0rc1/zepto.min"
	xenui: "../../xenui"

rAF = window.rAF = ((callback) ->
	window.requestAnimationFrame		||
	window.webkitRequestAnimationFrame	||
	window.mozRequestAnimationFrame		||
	window.oRequestAnimationFrame		||
	(callback) ->
		window.setTimeout(callback, 1000 / 60);
)()

require [ "zepto", "cs!xenui/xenui" ], init = (Zep, xenui) ->
	console.log(xenui.VERSION);
	root = this

	$ = root.Zepto or root.jQuery or root.ender
	can = $("#can")[0]
	ctx = can.getContext("2d")

	ctx.background = "black"
	ctx.fillRect(0, 0, 500, 500)

	view = new xenui.View("view", ctx)

	console.log "Setting up renderloop."
	rAF(render = ( t ) ->
		#!	Note:	Should only render /if/ there is a need to render!
		#!	FixME:	I am lazy as heck ;-)
		ctx.clearRect(0, 0, 500, 500)
		view.render(ctx)
		rAF(render)
	)

	#!	TODO: Code up Event to Signal-translator..
	console.log('EOM');