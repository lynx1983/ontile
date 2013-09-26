define [
	"backbone"
	"../vent"
], (Backbone, vent) ->

	class AbstractView extends Backbone.View
		constructor: (options)->
			@vent = vent
			super