define [
	"./Abstract"
], (AbstractView)->
	class MainMenuView extends AbstractView
		el: $("#main-menu")

		template: _.template $("#main-menu-template").html()

		initialize:->
			do @render

		render:->
			@$el.html @template
			@