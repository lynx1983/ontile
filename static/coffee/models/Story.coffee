define [
	"backbone"
], (Backbone)->
	class StoryModel extends Backbone.Model
		defaults:
			image: ""
			thumb: ""
			description: ""