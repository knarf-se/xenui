#	XenUI (JS Experiment version)
#	-----------------------------

#	© 2012 Frank M. Eriksson

define [ "zepto", "lib/signals" ], (Zep, Sig) ->
	XEN = VERSION: "0-WIP"
	root = this
	$ = root.Zepto or root.jQuery or root.ender
	class View
		constructor: (file) ->
			$.extend this,
				loaded:	false
				dirty:	true

			thiz = this
			console.log "Constructing new view", file, this
			require [ file ], (data) ->
				console.log "View data loaded", data
				thiz.ui = thiz.constructFrom(data)
				thiz.loaded = true

			this
		render: (ctx) ->
			return unless @loaded
			return unless @dirty
			@ui.render ctx

		constructFrom: (data) ->
			console.log "Constructing view from data"
			if data.type
				switch data.type
					when "label"
						new Label(data.xy[0], data.xy[1], data.text)
					when "button" 
						new Button(data.xy[0], data.xy[1], data.text)
					else
						throw "Unknow widget! ( " + data.type + " )"


	class Label
		constructor:  (@x, @y, text) ->
			$.extend this,
				text:		"Undefined label"
				font:		"14px sans-serif"
				strokeStyle:"green"
				fillStyle:	"black"
				outline:	false
				fill:		true
			@setText text
			console.log this
			this

		render: (ctx) ->
			ctx.save()
			ctx.font = @font
			if @fill
				ctx.fillStyle = @fillStyle
				ctx.fillText @text, @x, @y+14
			if @outline
				ctx.strokeStyle = @strokeStyle
				ctx.strokeText @text, @x, @y+14
			ctx.restore()

		setText: (text) ->
			@text	= text
			ctx		= document.createElement("canvas").getContext("2d")
			ctx.font= @font
			@width	= ctx.measureText(text).width
			console.log @width

	class Button extends Label
		constructor: (@x, @y, text) ->
			Signal = Sig.Signal
			@hover	= new Signal()
			@blur	= new Signal()
			@click	= new Signal()
			@colour	= 'salmon';
			@hover.add	()=>
				@colour = 'skyblue'
			@blur.add	()=>
				@colour = 'lightgray'
			@click.add	()=>
				@colour = 'limegreen'
			console.log @blur, @hover
			@hovering = false
			$('#can').on('mousemove', (e)=>
				#console.log(e)
				x = e.offsetX
				y = e.offsetY
				if(x>=@x&&y>=@y&&x<=@x+@width&&y<@y+19)
					if(!@hovering)
						@hover.dispatch()
					@hovering = true
				else
					if(@hovering)
						@blur.dispatch()
						@hovering = false
			).on('mousedown', (e)=>
				@clickjack = if(@hovering) then true else false
			).on('mouseup', (e)=>
				if(@hovering&&@clickjack) then @click.dispatch()
			)
			super(x,y,text)
		render: (ctx,t) ->
			ctx.beginPath();
			ctx.rect(@x,@y,@width,18);
			ctx.closePath();
			ctx.fillStyle	= @colour
			ctx.fill()
			ctx.strokeStyle	= 'black'
			ctx.stroke();
			super(ctx)

	$.extend XEN,
		View: View
