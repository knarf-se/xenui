#	XenUI (JS Experiment version)
#	-----------------------------

#	© 2012 Frank M. Eriksson

define [ "zepto" ], (Zep) ->
	XEN = VERSION: "0-WIP"
	root = this
	$ = root.Zepto or root.jQuery or root.ender
	class View
		constructor: (file) ->
			$.extend this,
				loaded: false
				dirty: true

			thiz = this
			console.log "Constructing new view", file, this
			require [ file ], (data) ->
				console.log "View data loaded", data
				thiz.ui = thiz.constructFrom(data)
				thiz.loaded = true

			this
		render: (ctx) ->
			return  unless @loaded
			return  unless @dirty
			@ui.render ctx

		constructFrom: (data) ->
			console.log "Constructing view from data"
			if data.type
				switch data.type
					when "label"
						return new Label(data.xy[0], data.xy[1], data.text)
					else
						throw "Unknow widget! ( " + data.type + " )"


	class Label
		constructor:  (@x, @y, text) ->
			$.extend this,
				text: "Undefined label"
				font: "14px sans-serif"
				strokeStyle: "green"
				fillStyle: "black"
				outline: false
				fill: true
			@setText text
			console.log this
			this

		render: (ctx) ->
			ctx.save()
			ctx.font = @font
			if @fill
				ctx.fillStyle = @fillStyle
				ctx.fillText @text, @x, @y
			if @outline
				ctx.strokeStyle = @strokeStyle
				ctx.strokeText @text, @x, @y
			ctx.restore()

		setText: (text) ->
			@text = text
			ctx = document.createElement("canvas").getContext("2d")
			ctx.font = @font
			@width = ctx.measureText(text)

	$.extend XEN,
		View: View
