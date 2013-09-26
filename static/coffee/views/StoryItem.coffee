define [
	"./Abstract"
], (AbstractView)->
	class StoryItemView extends AbstractView
		tagName: "li"

		attributes:
			class: "ui_item"

		template: _.template $("#story-item-template").html()

		events:
			"click img": "imageClick"

		render:->
			@$el.html @template
				thumb: @model.get "thumb"
				description: @model.get "description"
			@

		imageClick:->
			@trigger "item:show", @