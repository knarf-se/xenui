define ()->


# SEWR -- Simple Engine for Wigetet Rendering
	rAF = window.rAF = ((callback) ->
		window.requestAnimationFrame		||
		window.webkitRequestAnimationFrame	||
		window.mozRequestAnimationFrame		||
		window.oRequestAnimationFrame		||
		(callback) ->
			window.setTimeout(callback, 1000 / 60);
	)()
	class SEWR
		constructor: (ctx) ->
			@ctx	= if ctx.getContext then ctx.getContext('2d') else ctx
			@darker	= [[0,'#999'],[1,'#000']]
			@outset	= [[.0, "#fff"],[.05, "#eee"],[.1, "#fff"],[.5, "#ccc"],
				[.5, "#aaa"],[.90, "#888"],[1, "#aaa"]]
			@inset	= [[0, "#aaa"],[.05, "#888"],[.5, "#aaa"],[.5, "#ccc"],
				[.9, "#fff"],[.95, "#eee"],[1, "#fff"]]
			@flat	= [[.0, "#fff"],[.1, "#eee"],[.95, "#eee"],[1, "#ccc"]]

		colourizeGradient: (gradient, colourList) ->
			gradient.addColorStop(stop, colour) for [stop, colour] in colourList
			return gradient

		buildLinearGradient: (x0,y0, x1,y1, colourList) ->
			gradient = @ctx.createLinearGradient(x0,y0,x1,y1)
			@colourizeGradient(gradient, colourList)

		buildRadialGradient: (x0,y0,r0, x1,y1,r1, colourList) ->
			gradient = @ctx.createRadialGradient(x0,y0,r0,x1,y1,r1)
			@colourizeGradient(gradient, colourList)

		panel: (x,y,w,h, @grad) ->
			ctx = @ctx
			ctx.beginPath()
			ctx.rect(x,y,w,h);
			ctx.closePath()
			ctx.strokeStyle = @buildLinearGradient(x,y,x,y+h, @darker)
			ctx.stroke()	#	border seems to bleed 1px
			ctx.stroke()	#	because it's shifted ½ pixel
			ctx.fillStyle = @buildLinearGradient(11,37,11,64, @grad or @outset)
			ctx.fill()

		button: (region, state) ->
			{x,y,w,h} = region
			ctx = @ctx
			@panel(x,y,w,h, switch state
				when 'selected'
					@inset
				when 'hover'
					@flat
				else
					@outset
			)
			ctx.beginPath()
			ctx.rect(x,y+h*.78,w,h/7.6);
			ctx.closePath()
			ctx.fillStyle = @buildRadialGradient(x+w/2,y+h/2,5, x+w/2,y+h/2,77, switch state
				when 'selected'
					[[0,'#1ea'],[.4,"rgba(1,97,224,.3)"],[1,"rgba(1,98,159,0)"]]
				when 'hover'
					[[0,'#ae1'],[.4,"rgba(1,224,97,.3)"],[1,"rgba(1,159,98,0)"]]
				when 'active'
					[[0,'#ae1'],[.3,"rgba(1,224,97,.1)"],[1,"rgba(1,159,98,0)"]]
				else
					[[0,"rgba(0,0,0,0)"]]
			)
			ctx.fill()