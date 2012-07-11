#	XenUI (JS Experiment version)
#	-----------------------------
#	© 2012 Frank M. Eriksson

define [ "zepto", "./signals", "cs!./render" ], (Zep, Sig, Render) ->
	XEN = VERSION: "0-WIP"
	root = this
	$ = root.Zepto or root.jQuery or root.ender
	class View
		constructor: (file, ctx) ->
			@loaded		=	false
			@dirty 		=	true
			@Renderer	=	new Render(ctx)

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
			@Renderer.render(@ui)

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
			@region = new Region()
			@f	= "rgba(0,0,0,0)"
			@c	= "black"
			@p	= 3.5
		setXY: (x,y) ->
			@region.setXY x,y
			this

	class Region
		constructor: () ->
			#	global co-ordinates
			@x 	= 1
			@y	= 1
			@w	= 1
			@h	= 1
		#	Check if region contains a point
		contains: (x,y) ->
			(x>=@x&&y>=@y&&x<=@x+@w&&y<@y+@h)
		setXY: (@x,@y) ->
			this
		setWH: (@w,@h) ->
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

		setText: (text) ->
			@text	= text
			ctx		= document.createElement("canvas").getContext("2d")
			ctx.font= @font
			@width	= ctx.measureText(text).width
			@region.w = @width

	class Button extends Widget
		constructor: (text) ->
			super()
			@label = new Label(text)
			@region.setWH @label.width+7, 24
			Signal	= Sig.Signal
			@hover	= new Signal()
			@blur	= new Signal()
			@click	= new Signal()
			@state	= 'active';
			@hover.add	()=>
				@state = 'hover'
			@blur.add	()=>
				@state = ''
			@click.add	()=>
				@state = 'selected'
			@hovering = false
			$('#can').on('mousemove', (e)=>
				x = e.offsetX
				y = e.offsetY
				if(@region.contains(x,y))
					if(!@hovering)
						@hover.dispatch()
					@hovering = true
				else
					if(@hovering)
						@blur.dispatch()
						@hovering = false
			).on('mousedown', (e)=>
				@clickjack = if(@hovering) then true else false
				if(@hovering) then @state = 'selected'
			).on('mouseup', (e)=>
				if(@hovering&&@clickjack) then @click.dispatch()
				if(@state is 'selected') then @state = 'active'
			)
		setXY: (x,y) ->
			@label.setXY(x+@p,y+@p)
			super(x,y)

	$.extend XEN,
		View: View
