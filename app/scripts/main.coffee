################################################################################
# script: ChillSlide
# author: Mike McMillan <http://mcchill.in>
# license: MIT
################################################################################

class ChillSlide

	constructor: (container, options={}) ->
		# Set some default options
		@container = options.container ? $(".chill-slide__container")
		@numOfRows = options.numOfRows ? 2
		@slidee = @container.find("ul")
		@items = @slidee.find("li")
		@createRows()
		@calculateWidths()

	createRows: () =>
		numItemsInRow = Math.ceil(@items.length / @numOfRows)
		$lis = @slidee.children().filter(":gt(" + (numItemsInRow - 1) + ")")
		loop_ = Math.ceil($lis.length / numItemsInRow)
		i = 0

		while i < loop_
		  @slidee = $("<ul />").append($lis.slice(i * numItemsInRow, (i * numItemsInRow) + numItemsInRow)).insertAfter(@slidee)
		  i++

	calculateWidths: () =>
		@container.imagesLoaded =>
			@container.find("ul").each (i, obj) ->
				rowWidth = 0
				$(this).find("li").each ->
					rowWidth = rowWidth + $(this).outerWidth()

				$(this).addClass "row#{i + 1}"
				$(this).css
					"width": rowWidth + "px"


$ ->
	$(window).load ->
		window.chillSlide = new ChillSlide(
			container: $(".chill-slide__container"),
			numOfRows: 2
		)

