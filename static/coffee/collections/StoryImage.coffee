define [
	"module"
	"./Paged"
	"../models/StoryImage"
], (module, PagedCollection, StoryImageModel)->

	URL = module.config().url or "/wp-admin/admin-ajax.php?action=get_story_posts"

	class StoryImageCollection extends PagedCollection
		
		url: URL

		model: StoryImageModel

		initialize:(options)->
			super
			@id = options.id

		fetch:(options)->
			options = options or {}
			options.data =
				id: @id
			super options