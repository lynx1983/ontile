define [
	"backbone"
], (Backbone)->
	class AboutModel extends Backbone.Model
		defaults:
			content: ""
		
		url: "/json/about.json"
