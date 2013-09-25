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
)

require [
	"underscore"
	"backbone"
	"domReady"
	"views/Splash"	
	"routers/Main"
], (_, Backbone, domReady, SplashView, MainRouter)->
	domReady ->
		vent = _.extend({}, Backbone.Events);
		
		splashView = new SplashView
			afterComplete: ->
				appRouter = new MainRouter

				Backbone.history.start
					pushState: true