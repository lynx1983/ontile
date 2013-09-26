define [
	"./Abstract"
	"../collections/Story"
	"../views/StoryItem"
], (AbstractView, StoryCollection, StoryItemView)->
	class StoryView extends AbstractView
		el: $("#content")

		template: _.template $("#story-screen-template").html()

		events: 
			"click .ui_description .ui_button": "toggleDescription"

		initialize:->
			@options.view
			@listenTo @model, "sync", @render
			do @model.fetch

		toggleDescription:->
			@$el.find(".ui_description").toggleClass "closed"

		render:->
			@$el.html @template
				description: @model.get "description"
			@view = new @options.view
				id: @model.get "id"
				el: @$el.find ".content"
			@