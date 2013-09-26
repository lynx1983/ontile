define [
	"backbone"
	"../models/BackgroundImage"
], (Backbone, BackgroundImageModel)->
	class BackgroundImagesCollection extends Backbone.Collection
		url: "/json/background_images.json"

		model: BackgroundImageModel