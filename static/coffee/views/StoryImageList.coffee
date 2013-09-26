define [
	"./Abstract"
	"../collections/StoryImage"
	"../views/StoryImageItem"
], (AbstractView, StoryImageCollection, StoryImageItemView)->
	
	class StoryImageListView extends AbstractView
		template: _.template $("#story-image-list-template").html()

		initialize:->
			@id = @options.id
			@collection = new StoryImageCollection
				id: @id
			@listenTo @collection, "sync", @render
			do @collection.fetch

		render:->
			@$el.html @template
			@collection.each (item)=>
				itemView = new StoryImageItemView
					storyId: @id
					model: item
				@$el.find(".ui_items").append itemView.render().$el
			if do @collection.isFirstPage 
				do @$el.find(".ui_prev").hide
			else 
				do @$el.find(".ui_prev").show

			if do @collection.isLastPage 
				do @$el.find(".ui_next").hide
			else 
				do @$el.find(".ui_next").show
			@