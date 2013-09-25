define [
	"backbone"
	"../views/Main"
	"../views/MainMenu"
], (Backbone, MainView, MainMenuView)->

	class AppRouter extends Backbone.Router
		initialize:->
			@mainMenu = new MainMenuView

		routes:
			"": "index"

		index:->
			new MainView