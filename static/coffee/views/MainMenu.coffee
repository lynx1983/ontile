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
			@listenTo @, "route:before", @resetMenu
			@listenTo @, "route:after", @setActiveItem
			do @collection.fetch

		resetMenu:->
			@$el.find("li.active").removeClass "active"

		setActiveItem:(route)->
			@$el.find("a[href='/#{route}']").parents('li').addClass "active"

		render:->
			@$el.html @template
			@collection.each (item)=>
				menuItem = new MenuItemView
					model: item
				do menuItem.render	
				@$el.find("nav > .ui_menu").append menuItem.$el
			@