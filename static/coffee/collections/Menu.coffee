define [
	"module"
	"backbone"
	"../models/MenuItem"
], (module, Backbone, MenuItemModel)->

	URL = module.config().url or "/wp-admin/admin-ajax.php?action=get_menu"

	class MenuCollection extends Backbone.Collection
		url: URL

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