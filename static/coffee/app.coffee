requirejs.config(
	baseUrl: 'js',
	paths: 
		underscore: 'lib/underscore/underscore'
		backbone: 'lib/backbone/backbone'
		jquery: 'lib/jquery/jquery'
		domReady: 'lib/requirejs-domready/domReady'
	shim:
		jquery: 
			exports: 'jQuery'
		backbone:
			deps: ['underscore', 'jquery']
			exports: 'Backbone'
		underscore:
			exports: '_'
		domReady:
			exports: 'domReady'
	config:
		"collections/BackgroundImages":
			url: "/json/background_images.json"
		"collections/Menu":
			url: "/json/menu.json"
		"collections/Story":
			url: "/json/story.json"
		"models/About":
			url: "/json/about.json"
)

require [
	"underscore"
	"backbone"
	"domReady"
	"vent"
	"views/Splash"	
	"views/BackgroundImage"
	"views/MainMenu"
	"routers/Main"
], (_, Backbone, domReady, vent, SplashView, BackgroundImageView, MainMenuView, MainRouter)->
	domReady ->		
		splashView = new SplashView
			afterComplete: ->
				vent.trigger "app:started"

				Backbone.history.start
					pushState: true

				$(document).on 'click', 'a:not([data-bypass])', (e)->
					href = $(@).attr "href"
					protocol = "#{@protocol}//"

					if href.slice(protocol.length) isnt protocol
						do e.preventDefault
						appRouter.navigate href, true

		appRouter = new MainRouter
			vent: vent

		backgroundImage = new BackgroundImageView

		mainMenu = new MainMenuView

		splashView.addInitOperation do backgroundImage.init
		splashView.addInitOperation do mainMenu.init

		do splashView.startInit