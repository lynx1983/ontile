define [
	"./Abstract"
], (AbstractView)->
	class StoryImageItemView extends AbstractView
		tagName: "li"

		attributes:
			class: "ui_item"

		template: _.template $("#story-item-template").html()

		render:->
			@$el.html @template
				id: @model.get "id"
				storyId: @model.get "storyId"
				thumb: @model.get "thumb"
				description: @model.get "description"
			@