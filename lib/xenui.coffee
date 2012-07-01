#	XenUI (JS Experiment version)
#	-----------------------------
#	© 2012 Frank M. Eriksson

define [ "zepto", "../../lib/signals" ], (Zep, Sig) ->
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
						w = new Label(data.text)
					when "button" 
						w = new Button(data.text)
					else
						throw "Unknow widget! ( " + data.type + " )"
			w.setXY data.xy[0],  data.xy[1]

	class Widget
		constructor: () ->
			@x 	= 1
			@y	= 1
			@w	= 1
			@h	= 1
			@f	= "rgba(0,0,0,0)"
			@c	= "black"
			@p	= 3.5
		setXY: (@x,@y) ->
			this


	class Label extends Widget
		constructor: (text) ->
			super()
			@text		= "Undefined label"
			@font		= "14px sans-serif"
			@strokeStyle= "green"
			@fillStyle	= "black"
			@padding	= 5
			@outline	= false
			@fill		= true
			@setText text
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

	class Button extends Widget
		constructor: (text) ->
			super()
			@label = new Label(text)
			@w = @label.width+7
			Signal	= Sig.Signal
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
			@hovering = false
			$('#can').on('mousemove', (e)=>
				x = e.offsetX
				y = e.offsetY
				if(x>=@x&&y>=@y&&x<=@x+@w&&y<@y+24)
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
		setXY: (x,y) ->
			@label.setXY(x+@p,y+@p)
			super(x,y)
		render: (ctx,t) ->
			ctx.beginPath();
			ctx.rect(@x,@y,@w,24);
			ctx.closePath();
			ctx.fillStyle	= @colour
			ctx.fill()
			ctx.strokeStyle	= 'black'
			ctx.stroke();
			@label.render(ctx)

	$.extend XEN,
		View: View
