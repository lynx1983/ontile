define [
	"./Abstract"
	"../collections/BackgroundImages"
], (AbstractView, BackgroundImagesCollection)->
	class SplashView extends AbstractView
		el: $("#content")

		collection: new BackgroundImagesCollection

		attributes:
			class: "ui_splash"

		template: _.template $("#splash-screen-template").html()

		initialize:->
			do @render

		render:->
			@$el.html @template
			@
		
		afterComplete:->
			if _.isFunction @options.afterComplete
				@options.afterComplete.apply @