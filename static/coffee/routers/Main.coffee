define [
	"backbone"
	"../views/MainMenu"
	"../views/Index"
	"../views/About"
	"../views/Story"
], (Backbone, MainMenuView, IndexView, AboutView, StoryView)->

	class AppRouter extends Backbone.Router
		initialize:->
			@mainMenu = new MainMenuView
			@currentPage = null
			@listenTo @, "route:before", @reset
			@listenTo @, "route:after", @afterRoute

		route: (route, name, callback)->
			callback = @[name] unless callback
			super route, name, ->
				@trigger "route:before"
				result = callback and callback.apply @, arguments
				@trigger "route:after"
				result

		routes:
			"about": "showAbout"
			"stories/:id": "showStory"
			"*path": "showIndex"			

		showIndex:->
			@currentPage = new IndexView

		showAbout:->
			@currentPage = new AboutView

		showStory:(id)->
			@currentPage = new StoryView
				id: id

		afterRoute:->
			$("#content").show()

		reset:->
			if @currentPage
				delete @currentPage
			$('#content').hide()