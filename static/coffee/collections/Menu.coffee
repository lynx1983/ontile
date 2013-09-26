define [
	"backbone"
	"../models/MenuItem"
], (Backbone, MenuItemModel)->
	class MenuCollection extends Backbone.Collection
		url: "/json/menu.json"

		model: MenuItemModel

		fetch:->
			super
				success: @afterFetch

		afterFetch:(collection)->
			collection.each (item)->
				children = []
				itemChildren = item.get("children")
				if itemChildren.length 
					_.each itemChildren, (child)=>
						children.push new MenuItemModel child
				item.set "children", children