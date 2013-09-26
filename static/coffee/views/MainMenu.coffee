define [
	"./Abstract"
	"../collections/Menu"
	"../views/MenuItem"
], (AbstractView, MenuCollection, MenuItemView)->
	class MainMenuView extends AbstractView
		el: $("#main-menu")

		template: _.template $("#main-menu-template").html()

		collection: new MenuCollection

		events:
			"click .title.vertical": "showMenu"
			"click .title.horizontal": "hideMenu"

		initialize:->
			@deferred = new $.Deferred
			@deferred.done =>
				console.log "Menu complete"
			@listenTo @vent, "route:before", @resetMenu
			@listenTo @vent, "route:after", @setActiveItem
			@listenTo @collection, "sync", @afterLoad
			@listenTo @vent, "app:started", @render

		init:->
			@vent.trigger "progress:add"
			do @collection.fetch
			@deferred

		afterLoad:->
			@vent.trigger "progress:complete"
			do @deferred.resolve

		showMenu:->
			@$el.find("nav").addClass "opened"

		hideMenu:->
			@$el.find("nav").removeClass "opened"

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