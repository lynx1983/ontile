define [
	"./Abstract"
	"../collections/Menu"
	"../views/MenuItem"
], (AbstractView, MenuCollection, MenuItemView)->
	class MainMenuView extends AbstractView
		el: $("#main-menu")

		template: _.template $("#main-menu-template").html()

		collection: MenuCollection

		initialize:->
			@listenTo @collection, "sync", @render
			do @collection.fetch

		render:->
			@$el.html @template
			@collection.each (item)=>
				menuItem = new MenuItemView
					model: item
				do menuItem.render	
				@$el.find("nav > .ui_menu").append menuItem.$el
			@