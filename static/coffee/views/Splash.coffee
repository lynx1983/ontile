define [
	"./Abstract"
	"../collections/BackgroundImages"
], (AbstractView, BackgroundImagesCollection)->
	class SplashView extends AbstractView
		el: $("#content")

		attributes:
			class: "ui_splash"

		template: _.template $("#splash-screen-template").html()

		initialize:->
			do @render
			@deferreds = []
			@$indicator = @$el.find ".ui_indicator"
			@itemsToLoad = 0
			@itemsLoaded = 0
			@listenTo @vent, "progress:add", =>
				@itemsToLoad++
				do @progressBarRender
			@listenTo @vent, "progress:complete", =>
				@itemsLoaded++
				do @progressBarRender

		addInitOperation:(deferred)->
			@deferreds.push deferred

		startInit:->
			$.when.apply($, @deferreds).then =>
				console.log "Bingo!!!"
				do @afterComplete

		progressBarRender:->
			@$indicator.css "width", "#{@itemsLoaded / @itemsToLoad * 100}%"

		render:->
			@$el.html @template
			@
		
		afterComplete:->
			if _.isFunction @options.afterComplete
				@options.afterComplete.apply @