define ()->

#	SEWR -- Simple Engine for Widget Rendering
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
			#	This looks ugly..
			#	ToDo:	Load styledata from file
			@darker	= [[0,'#999'],[1,'#000']]
			@outset	= [[.0, "#fff"],[.05, "#eee"],[.1, "#fff"],[.5, "#ccc"],
				[.5, "#aaa"],[.90, "#888"],[1, "#aaa"]]
			@inset	= [[0, "#aaa"],[.05, "#888"],[.5, "#aaa"],[.5, "#ccc"],
				[.9, "#fff"],[.95, "#eee"],[1, "#fff"]]
			@flat	= [[.0, "#fff"],[.1, "#eee"],[.95, "#eee"],[1, "#ccc"]]

		render: (widget) ->
			switch widget.constructor.name
				when 'Button'
					@button widget
				when 'Label'
					@button widget
				else
					return

		colourizeGradient: (gradient, colourList) ->
			gradient.addColorStop(stop, colour) for [stop, colour] in colourList
			return gradient

		buildLinearGradient: (x0,y0, x1,y1, colourList) ->
			gradient = @ctx.createLinearGradient(x0,y0,x1,y1)
			@colourizeGradient(gradient, colourList)

		buildRadialGradient: (x0,y0,r0, x1,y1,r1, colourList) ->
			gradient = @ctx.createRadialGradient(x0,y0,r0,x1,y1,r1)
			@colourizeGradient(gradient, colourList)

		label: (label) ->
			ctx = @ctx
			ctx.save()
			ctx.font = label.font
			{text,fill,outline,fillStyle,strokeStyle} = label
			{x,y,w,h} = label.region
			if fill
				ctx.fillStyle = fillStyle
				ctx.fillText text, x, y+14
			if outline
				ctx.strokeStyle = strokeStyle
				ctx.strokeText text, x, y+14
			ctx.restore()

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

		button: (widget) ->
			{x,y,w,h} = widget.region
			ctx = @ctx
			@panel(x,y,w,h, switch widget.state
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
			#	This style data does no belong here
			ctx.fillStyle = @buildRadialGradient(x+w/2,y+h/2,5, x+w/2,y+h/2,77, switch widget.state
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
			@label(widget.label)