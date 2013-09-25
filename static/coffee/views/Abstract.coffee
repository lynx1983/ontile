define ["backbone"], (Backbone) ->

	vent = _.extend {}, Backbone.Events

	class AbstractView extends Backbone.View
		constructor: (options)->
			@vent = vent
			super