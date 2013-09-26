define [
	"./Abstract"
	"../collections/Story"
	"../views/StoryItem"
], (AbstractView, StoryCollection, StoryItemView)->
	class StoryView extends AbstractView
		el: $("#content")

		template: _.template $("#story-screen-template").html()

		initialize:->
			@id = @options.id
			@collection = new StoryCollection
				id: @id
			@listenTo @collection, "reset", @render
			@collection.fetch
				reset: true

		render:->
			@$el.html @template
			@collection.each (item)=>
				storyItem = new StoryItemView
					model: item
				do storyItem.render
				@$el.find(".ui_items").append storyItem.$el
			@