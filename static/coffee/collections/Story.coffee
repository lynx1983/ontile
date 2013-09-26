define [
	"module"
	"backbone"
	"../models/Story"
], (module, Backbone, StoryModel)->

	URL = module.config().url or "/wp-admin/admin-ajax.php?action=get_story"

	class StoriesCollection extends Backbone.Collection
		url: URL

		model: StoryModel

		initialize:(options)->
			@id = options.id
			@page = options.page or 0
			@perPage = options.perPage or 4
			@position = 0

		fetch:(options)->
			options = options or {}
			options.data =
				id: @id
			super options

		parse:(data)->
			@title = data.title
			@description = data.description
			@pageCount = Math.ceil data.items.length / @perPage
			data.items

		getPage:->
			_.first @rest(@page * @perPage), @perPage

		getItem:->
			@at @position

		isFirstPage:->
			@page is 0

		isFirst:->
			@position is 0

		isLastPage:->
			@page is @pageCount - 1

		isLast:->
			@position is @length - 1