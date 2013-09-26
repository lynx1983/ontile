define [
	"backbone"
], (Backbone)->

	class PagedCollection extends Backbone.Collection

		initialize:(options)->
			@total = 0
			@page = options.page or 1
			@perPage = options.perPage or 4

		fetch:(options)->
			options = options or {}
			options.data = _.extend options.data,
				page: @page
				perPage: @perPage
			super options

		parse:(data)->
			@total = data.total
			data.items

		isFirstPage:->
			@page is 1

		isLastPage:->
			@page is Math.ceil @total / @perPage