define [
	"./Abstract"
	"../models/About"
], (AbstractView, AboutModel)->
	class AboutView extends AbstractView
		el: $("#content")

		template: _.template $("#about-screen-template").html()

		model: new AboutModel

		initialize:->
			@listenTo @model, "sync", @render
			do @model.fetch


		render:->
			@$el.html @template
				content: @model.get "content"
			@