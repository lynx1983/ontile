define [
	"backbone"
], (Backbone)->
	class StoryModel extends Backbone.Model
		defaults:
			src: ""
			description: ""