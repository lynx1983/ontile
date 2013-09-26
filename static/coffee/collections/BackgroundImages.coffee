define [
	"module"	
	"backbone"
	"../models/BackgroundImage"
], (module, Backbone, BackgroundImageModel)->

	URL = module.config().url or "/wp-admin/admin-ajax.php?action=get_background_images"

	class BackgroundImagesCollection extends Backbone.Collection
		url: URL

		model: BackgroundImageModel