define [
	"./Abstract"
	"../collections/Story"
	"../views/StoryItem"
], (AbstractView, StoryCollection, StoryItemView)->
	class StoryView extends AbstractView
		el: $("#content")

		events: 
			"click .ui_description .ui_button": "toggleDescription"
			"click .ui_next": "nextPage"
			"click .ui_prev": "prevPage"
			"click .ui_close-full": "closeFull"

		initialize:->
			@id = @options.id
			@listTemplate = _.template $("#story-screen-template").html()
			@fullTemplate = _.template $("#story-screen-full-template").html()
			@mode = "list"
			@collection = new StoryCollection
				id: @id
			@listenTo @collection, "sync", @render
			@itemViews = []
			do @collection.fetch

		toggleDescription:->
			@$el.find(".ui_description").toggleClass "closed"

		render:->
			@$el.html if @mode is "list" then @listTemplate else @fullTemplate
			@$el.find(".ui_description article").html @collection.description
			do @updateView
			@

		updateView:->
			if @mode is "list"
				do @updateListView
			else
				do @updateFullView

		updateFullView:->
			item = @collection.getItem()
			@$el.find("img").attr "src", item.get("image")

			if do @collection.isFirst
				do @$el.find(".ui_prev").hide
			else 
				do @$el.find(".ui_prev").show

			if do @collection.isLast
				do @$el.find(".ui_next").hide
			else 
				do @$el.find(".ui_next").show

		updateListView:->
			_.each @itemViews, (itemView)=>
				@stopListening itemView
			@itemViews = []
			@$el.find(".ui_items").empty()
			_.each @collection.getPage(), (item)=>
				storyView = new StoryItemView
					model: item
				do storyView.render
				@itemViews.push storyView
				@listenTo storyView, "item:show", @showFull
				@$el.find(".ui_items").append storyView.$el

			if do @collection.isFirstPage
				do @$el.find(".ui_prev").hide
			else 
				do @$el.find(".ui_prev").show

			if do @collection.isLastPage
				do @$el.find(".ui_next").hide
			else 
				do @$el.find(".ui_next").show


		nextPage:->
			if @mode is "list"
				unless do @collection.isLastPage
					@collection.page++
					do @updateView
			else 
				unless do @collection.isLast
					@collection.position++
					do @updateView

		prevPage:->
			if @mode is "list"
				unless do @collection.isFirstPage
					@collection.page--
					do @updateView
			else
				unless do @collection.isFirst
					@collection.position--
					do @updateView

		showFull:(item)->
			@mode = "full"
			@collection.position = @collection.indexOf item.model
			do @render

		closeFull:->
			@mode = "list"
			do @render
