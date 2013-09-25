define [
	"backbone"
], (Backbone)->
	class BackgroundImagesCollection extends Backbone.Collection
		url: "/json/background_images.json"

		initialize:->
			do @fetch