define [
	"backbone"
], (Backbone)->
	class BackgroundImageModel extends Backbone.Model
		defaults:
			src: null
