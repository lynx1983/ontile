define [
	"backbone"
	"../models/Story"
], (Backbone, StoryModel)->
	class MenuCollection extends Backbone.Collection
		url: "/json/story.json"

		model: StoryModel

		initialize:(options)->
			@id = options.id

		fetch:(options)->
			console.log "Collection id #{@.id} fetch"
			options = options or {}
			options.data =
				id: @id
			super options