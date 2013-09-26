define [
	"./Abstract"
], (AbstractView)->
	class IndexView extends AbstractView
		el: $("#content")

		template: _.template $("#main-screen-template").html()

		initialize:->
			do @render

		render:->
			@$el.html @template
			@