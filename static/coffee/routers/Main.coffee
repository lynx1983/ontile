define [
	"backbone"
], (Backbone)->

	class AppRouter extends Backbone.Router

		routes:
			"": "index"

		index:->
			alert "index"