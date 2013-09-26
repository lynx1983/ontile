define [
	"./Abstract"
], (AbstractView)->
	class StoryItemView extends AbstractView
		tagName: "li"

		attributes:
			class: "ui_item"

		template: _.template $("#story-item-template").html()

		render:->
			@$el.html @template
				src: @model.get "src"
				description: @model.get "description"
			@