define [
	"backbone"
], (Backbone)->

	class StoryImageModel extends Backbone.Model
		defaults:
			id: null
			storyId: null
			thumb: ""
			title: ""
			description: ""