define [
	"./Abstract"
], (AbstractView)->
	class MenuItemView extends AbstractView
		tagName: "li"

		template: _.template $("#main-menu-item-template").html()

		render:->
			@$el.html @template
				name: @model.get "name"
				url: @model.get "url"
				children: @model.get("children").length
			if @model.get("children").length > 0
				_.each @model.get("children"), (item)=>
					child = new MenuItemView
						model: item
					@$el.find(".ui_sub-menu").append child.render().$el
			@