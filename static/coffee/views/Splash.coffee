define [
	"./Abstract"
	"../collections/BackgroundImages"
], (AbstractView, BackgroundImagesCollection)->
	class SplashView extends AbstractView
		el: $("#content")

		collection: BackgroundImagesCollection

		attributes:
			class: "ui_splash"

		template: _.template $("#splash-screen-template").html()

		initialize:->
			do @render
			@$indicator = @$el.find ".ui_indicator"
			@listenTo @collection, "reset", @onItemAdd
			@collection.loaded = 0
			@collection.fetch
				reset: true

		onItemAdd:->
			console.log "Item added"
			do @progressBarRender
			if @collection.length
				@collection.each (item)=>
					image = $('<img>')
					image.on "load", _.bind(@onItemLoaded, @)
					image.attr("src", item.get "src")
					item.set "image", image
			else
				@$indicator.css "width", "100%"
				do @afterComplete

		onItemLoaded:->
			@collection.loaded++
			do @progressBarRender
			if @collection.loaded is @collection.length
				do @afterComplete

		progressBarRender:->
			@$indicator.css "width", "#{@collection.loaded / @collection.length * 100}%"

		render:->
			@$el.html @template
			@
		
		afterComplete:->
			if _.isFunction @options.afterComplete
				@options.afterComplete.apply @