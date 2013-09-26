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
				id: @model.get "id"
				story_id: @model.get "story_id"
				thumb: @model.get "thumb"
				description: @model.get "description"
			@