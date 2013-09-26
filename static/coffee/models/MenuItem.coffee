define [
	"backbone"
], (Backbone)->
	class MenuItemModel extends Backbone.Model
		defaults:
			name: ""
			url: ""
			children: []
