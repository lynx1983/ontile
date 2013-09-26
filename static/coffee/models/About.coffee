define [
	"module"
	"backbone"
], (module, Backbone)->

	URL = module.config().url or "/wp-admin/admin-ajax.php?action=get_page&slug=about"

	class AboutModel extends Backbone.Model
		defaults:
			content: ""
		
		url: URL
