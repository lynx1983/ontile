define [
	"backbone"
	"../views/MainMenu"
	"../views/Index"
	"../views/About"
	"../views/Story"
	"../views/StoryImageList"
	"../models/Story"
], (Backbone, MainMenuView, IndexView, AboutView, StoryView, StoryImageListView, StoryModel)->

	class AppRouter extends Backbone.Router
		initialize:(options)->
			@vent = options.vent
			@currentPage = null
			@listenTo @vent, "route:before", @reset
			@listenTo @vent, "route:after", @afterRoute

		route: (route, name, callback)->
			callback = @[name] unless callback
			super route, name, ->
				@vent.trigger "route:before"
				result = callback and callback.apply @, arguments
				@vent.trigger "route:after", Backbone.history.fragment
				result

		routes:
			"about(/)": "showAbout"
			"stories/:id/:image/full(/)": "showFullImage"
			"stories/:id(/)": "showStory"
			"*path": "showIndex"			

		showIndex:->
			@currentPage = new IndexView

		showAbout:->
			@currentPage = new AboutView

		showStory:(id)->
			@currentPage = new StoryView
				model: new StoryModel
					id: id
				view: StoryImageListView

		showFullImage:(id, image)->
			@currentPage = new StoryView
				id: id
				mode: "full"

		afterRoute:->
			$("#content").removeClass("closed")

		reset:->
			if @currentPage
				delete @currentPage
			$("#content").addClass("closed")