define [
	"backbone"
], (Backbone)->
	class StoryModel extends Backbone.Model
		defaults:
			id: null
			story_id: null
			image: ""
			thumb: ""
			description: ""