define [
	"./Abstract"
	"../collections/BackgroundImages"
], (AbstractView, BackgroundImagesCollection)->
	class BackgroundImageView extends AbstractView

		initialize:->
			@deferred = new $.Deferred
			@imgDeferreds = []
			@deferred.done ->
				console.log "BG done"
			@collection = new BackgroundImagesCollection
			@listenTo @collection, "sync", @loadImages

		loadImages:->
			@vent.trigger "progress:complete"
			if @collection.length is 0
				do @deferred.resolve
			else
				@collection.each (item)=>
					image = $('<img>')
					image.attr("src", item.get "src")
					item.set "image", image
					deferred = new $.Deferred
					image.on "load", =>
						@vent.trigger "progress:complete"
						do deferred.resolve
					@imgDeferreds.push deferred
					@vent.trigger "progress:add"

				$.when.apply(@, @imgDeferreds).then =>
					setTimeout =>
						do @deferred.resolve
					, 1000


		init:->
			@vent.trigger "progress:add"
			do @collection.fetch
			@deferred

		render:->
			console.log "BG Images render"
			@

		showNext:->