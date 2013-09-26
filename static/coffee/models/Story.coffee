define [
	"module"
	"backbone"
], (module, Backbone)->

	URL = module.config().url or "/wp-admin/admin-ajax.php?action=get_story"

	class StoryModel extends Backbone.Model
		defaults:
			id: null
			title: ""
			description: ""

		url: URL

		fetch:->
			super
				data:
					id: @get "id"

