define [
	"./Abstract"
	"../collections/BackgroundImages"
], (AbstractView, BackgroundImagesCollection)->
	class BackgroundImageView extends AbstractView

		el: $("#content")

		initialize:->
			@deferred = new $.Deferred
			@imgDeferreds = []
			@collection = new BackgroundImagesCollection
			@listenTo @collection, "sync", @loadImages
			@listenTo @vent, "app:started", @render

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
					do @deferred.resolve

		init:->
			@vent.trigger "progress:add"
			do @collection.fetch
			@deferred

		render:->
			i = _.random this.collection.length - 1
			@$el.css "background-image", "url(" + @collection.at(i).get("src") + ")"
			setTimeout =>
				do @render
			, 60000
			@

		showNext:->